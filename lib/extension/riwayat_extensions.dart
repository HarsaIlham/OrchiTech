import 'package:intl/intl.dart';
import 'package:orchitech/models/riwayat_pendingin_model.dart';
import 'package:orchitech/models/riwayat_penyiraman_model.dart';

extension RiwayatFormatIndo on RiwayatPendinginModel {
  String get tanggalIndo => DateFormat('d MMMM yyyy', 'id_ID').format(createdAt);
  String get jamIndo => DateFormat('HH:mm', 'id_ID').format(createdAt);
}

extension RiwayatFormatIndoPenyiraman on RiwayatPenyiramanModel {
  String get tanggalIndo => DateFormat('d MMMM yyyy', 'id_ID').format(createdAt);
  String get jamIndo => DateFormat('HH:mm', 'id_ID').format(createdAt);
  String get hariIndo => DateFormat('EEEE', 'id_ID').format(createdAt); // Menambahkan nama hari
}