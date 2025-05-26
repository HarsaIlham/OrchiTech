import 'package:orchitech/models/status_aktivasi_penyiraman.dart';
import 'package:orchitech/services/mqtt_services.dart';

class StatusPenyiramanController {
  final _mqttService = MqttService();
  Stream<bool> getStatusPenyiraman1() {
    return _mqttService
        .subscribe('orchitech/penyiraman1')
        .where((data) => data.containsKey('status'))
        .map((data) => data['status'] == 'On')
        .asBroadcastStream(); // menyaring null
  }

  Stream<bool> getStatusPenyiraman2() {
    return _mqttService
        .subscribe('orchitech/penyiraman2')
        .where((data) => data.containsKey('status'))
        .map((data) => data['status'] == 'On')
        .asBroadcastStream();
  }

  Future<void> editStatusPenyiraman(bool status, int id) async {
    return StatusAktivasiPenyiraman.updateStatusAktivasiPenyiraman(status, id);
  }
}
