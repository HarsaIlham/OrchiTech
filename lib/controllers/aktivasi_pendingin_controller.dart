import 'package:orchitech/models/status_aktivasi_pendingin.dart';
import 'package:orchitech/services/mqtt_services.dart';

class AktivasiPendinginController {
  // Singleton pattern supaya hanya ada satu instance stream

  final _mqttService = MqttService();
  Stream<bool> getStatus() {
    return _mqttService
        .subscribe('orchitech/status')
        .where((data) => data.containsKey('status'))
        .map((data) => data['status'] == 'On')
        .asBroadcastStream(); // menyaring null
  }

  Stream<StatusAktivasiPendingin?> getDatabaseStream() {
    return StatusAktivasiPendingin.streamFromDatabase();
  }

  Future<void> editBatasSuhu(int batasBaru) async {
    await StatusAktivasiPendingin.updateBatasSuhu(batasBaru);
  }

  Future<void> editStatusPendingin(bool status) async {
    await StatusAktivasiPendingin.updateStatusAktivasiPendingin(status);
  }
}
