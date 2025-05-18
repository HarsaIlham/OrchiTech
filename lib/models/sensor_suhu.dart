import 'package:orchitech/services/mqtt_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final MqttService _mqttService = MqttService();
final supabase = Supabase.instance.client;

class SensorSuhu {
  final double suhu;
  final int kelembaban;

  SensorSuhu({required this.suhu, required this.kelembaban});

  factory SensorSuhu.fromMap(Map<String, dynamic> map) {
    return SensorSuhu(
      suhu: (map['suhu'] as num).toDouble(),
      kelembaban: map['kelembaban'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {'suhu': suhu, 'kelembaban': kelembaban};
  }

  // static Stream<SensorSuhu?> getSensorRealtime() async* {
  //   // Ambil data awal (terbaru)
  //   final initial =
  //       await supabase
  //           .from('suhu_dan_kelembaban')
  //           .select()
  //           .order('timestamp', ascending: false)
  //           .limit(1)
  //           .maybeSingle();

  //   if (initial != null) {
  //     yield SensorSuhu.fromMap(initial);
  //   }

  //   // Listen perubahan realtime
  //   yield* supabase
  //       .from('suhu_dan_kelembaban')
  //       .stream(primaryKey: ['id'])
  //       .order('timestamp', ascending: false)
  //       .limit(1)
  //       .map((rows) => rows.isNotEmpty ? SensorSuhu.fromMap(rows.first) : null);
  // }

  static Stream<SensorSuhu?>? _sensorStream;

  static Stream<SensorSuhu?> getSuhu() {
    // Jika sudah ada stream, langsung return yang sudah diinisialisasi
    if (_sensorStream != null) {
      return _sensorStream!;
    }

    // Inisialisasi koneksi dan streaming data
    _sensorStream = (() async* {
      await _mqttService.connect();

      // Subscribe ke topic yang diinginkan
      yield* _mqttService.subscribe('orchitech/sensor').map((dataMap) {
        try {
          // Mapping data MQTT ke dalam Model
          print('✅ Data received from MQTT: $dataMap');
          return SensorSuhu.fromMap(dataMap);
        } catch (e) {
          print('Error parsing data from MQTT: $e');
          return null;
        }
      });
    })().asBroadcastStream();

    return _sensorStream!;
  }
}
