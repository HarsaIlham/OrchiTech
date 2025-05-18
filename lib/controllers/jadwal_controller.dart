import 'package:flutter/material.dart';
import 'package:orchitech/models/jadwal_penyiraman.dart';
import 'package:orchitech/services/mqtt_services.dart';

final _mqttService = MqttService();
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

  static Future<void> updateStatusPenyiraman(int id, bool status) async {
    try {
      await supabase
          .from('status_aktivasi_pendingin')
          .update({'status_aktivasi_pendingin': status})
          .eq('id_status_aktivasi_pendingin', 1);

      print('Status pendingin berhasil diperbarui: $status');

      _mqttService.publish('orchitech/status', status ? '{"status" : "ON"}' : '{"status" : "OFF"}'); // Sesuaikan dengan topik MQTT yang sesuaion' : 'off');
    } catch (e) {
      print('Error update status pendingin: $e');
    }
  }
}