import 'dart:async';
import 'dart:convert';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_data.dart';

class MqttService {
  static final MqttService _instance = MqttService._internal();
  final MqttServerClient client;
  final List<String> _subscribedTopics = [];
  final _connectionStatusController = StreamController<bool>.broadcast();

  factory MqttService() {
    return _instance;
  }

  MqttService._internal()
    : client = MqttServerClient('broker.hivemq.com', 'orchitech_client') {
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.logging(on: false);
    client.onDisconnected = onDisconnected;
  }

  /// Listen status koneksi (Connected/Disconnected)
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  /// Callback ketika MQTT terputus
  static void onDisconnected() {
    print('🔌 MQTT Client Disconnected');
  }

  /// Connect to MQTT broker (dengan auto-reconnect)
  Future<void> connect() async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('✅ MQTT is already connected.');
      return;
    }

    try {
      print('🔄 Attempting MQTT connection...');
      await client.connect();
      print('✅ Connected to MQTT broker.');

      // Subscribe ulang ke topik sebelumnya
      for (final topic in _subscribedTopics) {
        client.subscribe(topic, MqttQos.atMostOnce);
      }

      _connectionStatusController.add(true);
    } catch (e) {
      print('⚠️ Error connecting to MQTT broker: $e');
      _connectionStatusController.add(false);
      await Future.delayed(Duration(seconds: 5));
      await connect();
    }
  }

  /// Subscribe ke topik tertentu dan tambahkan ke list
  Stream<Map<String, dynamic>> subscribe(String topic) async* {
    if (!_subscribedTopics.contains(topic)) {
      _subscribedTopics.add(topic);
    }
    await connect();
    client.subscribe(topic, MqttQos.atMostOnce);

    await for (final messages in client.updates!) {
      for (final message in messages) {
        final payload = (message.payload as MqttPublishMessage).payload.message;
        final dataString = String.fromCharCodes(payload);

        print('📥 Message received on $topic: $dataString');

        // 📝 Coba parsing langsung ke Map
        try {
          final dataMap = jsonDecode(dataString) as Map<String, dynamic>;
          yield dataMap;
        } catch (e) {
          print('⚠️ Failed to parse message as JSON: $e');
        }
      }
    }
  }

  /// Publish pesan ke topik tertentu
  void publish(String topic, String message) {
    final payload = Uint8Buffer()..addAll(message.codeUnits);
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.publishMessage(topic, MqttQos.atLeastOnce, payload);
      print('✅ Message published to $topic: $message');
    } else {
      print('⚠️ MQTT not connected, message not sent.');
    }
  }
}
