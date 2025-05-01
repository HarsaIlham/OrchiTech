import 'package:firebase_database/firebase_database.dart';
import 'sensor_suhu.dart';

class FirebaseService {
  final DatabaseReference _suhuRef =
      FirebaseDatabase.instance.ref('suhu_dan_kelembaban');
  final DatabaseReference _statusRef =
      FirebaseDatabase.instance.ref('status_aktivasi_pendingin');

  Stream<StatusAktivasiPendingin?> getLatestStatus() {
    return _statusRef.orderByKey().limitToLast(1).onValue.map((event) {
      final dataMap = event.snapshot.value as Map?;
      if (dataMap == null) return null;

      final latestKey = dataMap.keys.first.toString();
      final latestData = Map<String, dynamic>.from(dataMap[latestKey]);

      return StatusAktivasiPendingin.fromMap(latestKey, latestData);
    });
  }

  Stream<SensorSuhu?> getLatestSuhu(int id) {
    return _suhuRef.child('$id').onValue.map((event) {
        final data = event.snapshot.value as Map?;
        if (data == null ) return null;

        final suhu = SensorSuhu.fromMap(data);
        return suhu;
      });
  }
}
