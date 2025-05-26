import 'package:orchitech/models/riwayat_penyiraman_model.dart';

class RiwayatPenyiramanController {
  Stream<List<RiwayatPenyiramanModel>> showRiwayat() {
    return RiwayatPenyiramanModel.fetchRiwayatPenyiraman();
  }
}
