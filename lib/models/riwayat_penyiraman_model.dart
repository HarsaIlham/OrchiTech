import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RiwayatPenyiramanModel {
  final int id;
  final DateTime createdAt;
  final int idJalurPenyiraman;

  RiwayatPenyiramanModel({
    required this.id,
    required this.createdAt,
    required this.idJalurPenyiraman,
  });

  factory RiwayatPenyiramanModel.fromJson(Map<String, dynamic> json) {
    return RiwayatPenyiramanModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      idJalurPenyiraman: json['id_jalur_penyiraman'],
    );
  }

  static Stream<List<RiwayatPenyiramanModel>> fetchRiwayatPenyiraman() {
    final stream = supabase
        .from('riwayat_penyiraman')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);

    return stream.map((records) {
      return records
          .map((json) => RiwayatPenyiramanModel.fromJson(json))
          .toList();
    });
  }
}
