import 'package:orchitech/services/mqtt_services.dart';

final _mqttService = MqttService();

class StatusAktivasiPenyiraman {
  final int id;
  final bool status;

  StatusAktivasiPenyiraman({required this.id, required this.status});

  factory StatusAktivasiPenyiraman.fromJson(Map<String, dynamic> json) {
    return StatusAktivasiPenyiraman(
      id: json['id'],
      status: json['status_penyiraman'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'status_penyiraman': status};

  static Future<void> updateStatusAktivasiPenyiraman(bool status, int id) async {
    try {
      _mqttService.publish(
        'orchitech/penyiraman$id',
        status
            ? '{"status": "On", "source": "manual"}'
            : '{"status": "Off", "source": "manual"}',
      ); // Sesuaikan dengan topik MQTT yang sesuaion' : 'off');
    } catch (e) {
      print('Error update status pendingin: $e');
    }
  }
}
