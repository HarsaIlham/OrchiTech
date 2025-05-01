class SensorSuhu {
  final double suhu;
  final double kelembaban;

  SensorSuhu({required this.suhu, required this.kelembaban});

  factory SensorSuhu.fromMap(Map data) {
    return SensorSuhu(
      suhu: (data['suhu'] ?? 0).toDouble(),
      kelembaban: (data['kelembaban'] ?? 0).toDouble(),
    );
  }
}

class StatusAktivasiPendingin {
  final int id;
  final int idSuhu;
  final int statusPendingin;
  final int batasSuhu;

  StatusAktivasiPendingin({
    required this.id,
    required this.idSuhu,
    required this.statusPendingin,
    required this.batasSuhu,
  });

  factory StatusAktivasiPendingin.fromMap(String key, Map data) {
    return StatusAktivasiPendingin(
      id: int.tryParse(key) ?? 0,
      idSuhu: (data['id_suhu_dan_kelembaban'] ?? 0),
      statusPendingin: (data['status_pendingin'] ?? 0),
      batasSuhu: (data['batas_suhu'] ?? 0),
    );
  }
}
