import 'package:orchitech/models/riwayat_pendingin_model.dart';

class RiwayatPendinginController {
  Stream<List<RiwayatPendinginModel>> showRiwayat() {
    return RiwayatPendinginModel.realtimeRiwayatPendingin();
  }
}
