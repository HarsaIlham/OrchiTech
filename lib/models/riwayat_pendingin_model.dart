import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RiwayatPendinginModel {
  final int id;
  final DateTime createdAt;
  final double suhu;

  RiwayatPendinginModel({
    required this.id,
    required this.suhu,
    required this.createdAt,
  });

  factory RiwayatPendinginModel.fromJson(Map<String, dynamic> json) {
    return RiwayatPendinginModel(
      id: json['id'],
      suhu: (json['suhu'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  static Stream<List<RiwayatPendinginModel>> realtimeRiwayatPendingin() {
    final stream = supabase
        .from('riwayat_pendingin')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);

    return stream.map((records) {
      return records.map((json) => RiwayatPendinginModel.fromJson(json)).toList();
    });
  }
}
