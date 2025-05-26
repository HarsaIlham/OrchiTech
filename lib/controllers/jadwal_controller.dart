import 'package:flutter/material.dart';
import 'package:orchitech/models/jadwal_penyiraman.dart';

class JadwalController {
  Future<JadwalPenyiraman?> showJadwal(int id) async {
    return JadwalPenyiraman.fetchWateringScheduleById(id);
  }

  Future<void> ubahJadwal(int id, List<String> hari, TimeOfDay waktu) async {
    await JadwalPenyiraman.updateJadwalPenyiraman(
      idJalur: id,
      hari: hari,
      waktu: waktu,
    );
  }

}