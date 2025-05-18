import 'package:orchitech/models/status_aktivasi_pendingin.dart';

class AktivasiPendinginController {
  Stream<StatusAktivasiPendingin?> showStatusPendingin() {
    return StatusAktivasiPendingin.getStatusPendingin();
  }

  Future<void> editBatasSuhu(double batasBaru) async {
    await StatusAktivasiPendingin.updateBatasSuhu(batasBaru);
  }

  Future<void> editStatusPendingin(bool status) async {
    await StatusAktivasiPendingin.updateStatusAktivasiPendingin(status);
  }
}