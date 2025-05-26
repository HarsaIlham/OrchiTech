import 'package:orchitech/models/sensor_suhu.dart';

class SensorSuhuController {
  Stream<SensorSuhu>? _sensorStream;

  Stream<SensorSuhu> get sensorStream {
    if (_sensorStream != null) return _sensorStream!;
    _sensorStream = SensorSuhu.getSuhudanKelembaban()
        .where((event) => event != null) // filter null
        .cast<SensorSuhu>() // pastikan tipe Stream<SensorSuhu>
        .asBroadcastStream();
    return _sensorStream!;
  }
}