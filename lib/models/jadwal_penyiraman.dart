import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
class JadwalPenyiraman {
  final int id;
  final String nama;
  final TimeOfDay waktu;
  final List<String> hari;
  final int idJalur;

  JadwalPenyiraman({
    required this.id,
    required this.nama,
    required this.waktu,
    required this.hari,
    required this.idJalur,
  });

  factory JadwalPenyiraman.fromJson(Map<String, dynamic> json) {
    final timeParts = (json['waktu'] as String).split(':');
    return JadwalPenyiraman(
      id: json['id_jadwal_penyiraman'],
      nama: json['nama'],
      waktu: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      hari: List<String>.from(json['hari']),
      idJalur: json['id_jalur'],
    );
  }

  static Future<JadwalPenyiraman?> fetchWateringScheduleById(int idJalur) async {
    try {
      final response =
          await supabase
              .from('jadwal_penyiraman')
              .select()
              .eq('id_jalur', idJalur) // Memfilter berdasarkan ID
              .single(); // Ambil satu hasil (karena ID unik)

      if (response.isEmpty) {
        print('❌ Jadwal penyiraman dengan ID $idJalur tidak ditemukan.');
      } else {
        print('✅ Berhasil membaca jadwal penyiraman dengan ID $idJalur.');
        return JadwalPenyiraman.fromJson(response);
      }
    } catch (e) {
      print('❌ Error membaca jadwal penyiraman: $e');
      return null; // Mengembalikan null jika terjadi kesalahan
    }
    return null;
  }

  static Future<void> updateJadwalPenyiraman({
    required int idJalur,
    required List<String> hari,
    required TimeOfDay waktu,
  }) async {

    final waktuFormatted =
        '${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}';

    final response = await supabase
        .from('jadwal_penyiraman')
        .update({'hari': hari, 'waktu': waktuFormatted})
        .eq('id_jalur', idJalur);

    if (response.error != null) {
      throw Exception('Gagal update penyiraman: ${response.error!.message}');
    }
  }

  static Future<void> updateStatusPenyiraman(int idJadwalPenyiraman, bool status) async {
    final response = await supabase
        .from('jadwal_penyiraman')
        .update({'status': status})
        .eq('id_jadwal_penyiraman', idJadwalPenyiraman);

    if (response.error != null) {
      throw Exception('Gagal update penyiraman: ${response.error!.message}');
    }
  }
}
