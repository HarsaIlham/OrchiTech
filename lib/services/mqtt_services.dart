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
  bool _isConnecting = false;
  factory MqttService() => _instance;

  MqttService._internal()
    : client = MqttServerClient('broker.hivemq.com', 'orchitech_client') {
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.logging(on: false);

    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onAutoReconnect = _onAutoReconnect;
    client.onAutoReconnected = _onAutoReconnected;
  }

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  static void _onDisconnected() {
    print('🔌 MQTT Client Disconnected');
  }

  void _onConnected() {
    print('✅ MQTT Client Connected');
    _connectionStatusController.add(true);
    // Subscribe ulang ke semua topik setelah koneksi
    for (final topic in _subscribedTopics) {
      client.subscribe(topic, MqttQos.atMostOnce);
    }
  }

  void _onAutoReconnect() {
    print('🔄 MQTT Client is trying to reconnect...');
  }

  void _onAutoReconnected() {
    print('✅ MQTT Client reconnected');
    // Subscribe ulang setelah reconnect
    for (final topic in _subscribedTopics) {
      client.subscribe(topic, MqttQos.atMostOnce);
    }
  }

  Future<void> connect() async {
    if (_isConnecting ||
        client.connectionStatus?.state == MqttConnectionState.connected) {
      return;
    }

    _isConnecting = true;

    try {
      print('🔄 Connecting to MQTT broker...');
      await client.connect();
    } catch (e) {
      print('⚠️ MQTT connection failed: $e');
      client.disconnect();
      _connectionStatusController.add(false);
      await Future.delayed(Duration(seconds: 5));
    } finally {
      _isConnecting = false;
    }

    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      // Coba reconnect hanya 1 kali setelah delay
      await connect();
    }
  }

  Stream<Map<String, dynamic>> subscribe(String topic) async* {
    if (!_subscribedTopics.contains(topic)) {
      _subscribedTopics.add(topic);
      print("TOPIC = ${_subscribedTopics}");
    }

    if (client.connectionStatus?.state != MqttConnectionState.connected) {
      await connect();
    }

    client.subscribe(topic, MqttQos.atMostOnce);

    await for (final messages in client.updates!) {
      for (final message in messages) {
        if (message.topic == topic) {
          final payload =
              (message.payload as MqttPublishMessage).payload.message;
          final dataString = String.fromCharCodes(payload);

          print('📥 Message received on $topic: $dataString');

          try {
            final dataMap = jsonDecode(dataString) as Map<String, dynamic>;
            yield dataMap;
          } catch (e) {
            print('⚠️ JSON parse error: $e');
          }
        }
      }
    }
  }

  void publish(String topic, String message) {
    final payload = Uint8Buffer()..addAll(message.codeUnits);
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      client.publishMessage(topic, MqttQos.atLeastOnce, payload);
      print('✅ Published to $topic: $message');
    } else {
      print('⚠️ MQTT not connected, publish failed');
    }
  }
}
