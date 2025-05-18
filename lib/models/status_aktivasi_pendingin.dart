import 'package:orchitech/services/mqtt_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final MqttService _mqttService = MqttService();

class StatusAktivasiPendingin {
  final int id;
  final bool statusPendingin;
  final int batasSuhu;
  final DateTime createdAt;

  StatusAktivasiPendingin({
    required this.id,
    required this.statusPendingin,
    required this.batasSuhu,
    required this.createdAt,
  });

  factory StatusAktivasiPendingin.fromMap(Map<String, dynamic> map) {
    return StatusAktivasiPendingin(
      id: map['id_status_aktivasi_pendingin'] as int,
      statusPendingin: map['status_aktivasi_pendingin'] as bool,
      batasSuhu: map['batas_suhu'] as int,
      createdAt: DateTime.parse(map['created_at']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id_status_aktivasi_pendingin': id,
      'status_aktivasi_pendingin': statusPendingin,
      'batas_suhu': batasSuhu,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static Stream<StatusAktivasiPendingin?> getStatusPendingin() async* {
    final initial =
        await supabase
            .from('status_aktivasi_pendingin')
            .select()
            .order('created_at', ascending: false)
            .limit(1)
            .maybeSingle();

    if (initial != null) {
      yield StatusAktivasiPendingin.fromMap(initial);
    }

    // Listen perubahan realtime
    yield* supabase
        .from('status_aktivasi_pendingin')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(1)
        .map(
          (rows) =>
              rows.isNotEmpty
                  ? StatusAktivasiPendingin.fromMap(rows.first)
                  : null,
        );
  }

  static Future<void> updateBatasSuhu(double batasBaru) async {
    try {
      final response = await supabase
          .from('status_aktivasi_pendingin')
          .update({'batas_suhu': batasBaru})
          .eq('id', 1); // atau ID yang sesuai

      if (response.isEmpty) {
        print('Gagal update. Data tidak ditemukan.');
      } else {
        print('Berhasil update batas suhu.');
      }
    } catch (e) {
      print('Error saat update batas suhu: $e');
    }
  }

  static Future<void> updateStatusAktivasiPendingin(bool status) async {
    try {
      await supabase
          .from('status_aktivasi_pendingin')
          .update({'status_aktivasi_pendingin': status})
          .eq('id_status_aktivasi_pendingin', 1);

      print('Status pendingin berhasil diperbarui: $status');

      _mqttService.publish('orchitech/status', status ? '{"status" : "ON"}' : '{"status" : "OFF"}'); // Sesuaikan dengan topik MQTT yang sesuaion' : 'off');
    } catch (e) {
      print('Error update status pendingin: $e');
    }
  }
}
