// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:orchitech/models/jadwal_penyiraman.dart';
import 'package:orchitech/models/status_aktivasi_pendingin.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/sensor_suhu.dart';

final supabase = Supabase.instance.client;

class SupabaseService {
  Stream<SensorSuhu?> getSensorRealtime() async* {
    // Ambil data awal (terbaru)
    final initial =
        await supabase
            .from('suhu_dan_kelembaban')
            .select()
            .order('timestamp', ascending: false)
            .limit(1)
            .maybeSingle();

    if (initial != null) {
      yield SensorSuhu.fromMap(initial);
    }

    // Listen perubahan realtime
    yield* supabase
        .from('suhu_dan_kelembaban')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: false)
        .limit(1)
        .map((rows) => rows.isNotEmpty ? SensorSuhu.fromMap(rows.first) : null);
  }

  Stream<StatusAktivasiPendingin?> getStatusPendingin() async* {
    final initial =
        await supabase
            .from('status_aktivasi_pendingin')
            .select()
            .order('created_at', ascending: false)
            .limit(1)
            .maybeSingle();

    if (initial != null) {
      yield StatusAktivasiPendingin.fromMap(initial);
    }

    // Listen perubahan realtime
    yield* supabase
        .from('status_aktivasi_pendingin')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(1)
        .map(
          (rows) =>
              rows.isNotEmpty
                  ? StatusAktivasiPendingin.fromMap(rows.first)
                  : null,
        );
  }

  Future<void> updateBatasSuhu(double batasBaru) async {
    try {
      final response = await supabase
          .from('status_aktivasi_pendingin')
          .update({'batas_suhu': batasBaru})
          .eq('id', 1); // atau ID yang sesuai

      if (response.isEmpty) {
        print('Gagal update. Data tidak ditemukan.');
      } else {
        print('Berhasil update batas suhu.');
      }
    } catch (e) {
      print('Error saat update batas suhu: $e');
    }
  }

  Future<void> updateStatusAktivasiPendingin(bool status) async {
    try {
      await supabase
          .from('status_aktivasi_pendingin')
          .update({'status_aktivasi_pendingin': status})
          .eq('id_status_aktivasi_pendingin', 1);

      print('✅ Status pendingin berhasil diperbarui: $status');
    } catch (e) {
      print('❌ Error update status pendingin: $e');
    }
  }

  Future<JadwalPenyiraman?> fetchWateringScheduleById(int idJalur) async {
    try {
      final response =
          await Supabase.instance.client
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

  Future<void> updateJadwalPenyiraman({
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
}
