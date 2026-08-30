import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeviceControlService {
  late MqttServerClient client;
  final logger = Logger();
  bool _isConnected = false;

  Future<bool> connectToMQTT() async {
    try {
      final brokerUrl = dotenv.env['MQTT_BROKER_URL'] ?? 'localhost';
      final brokerPort = int.parse(dotenv.env['MQTT_BROKER_PORT'] ?? '1883');

      client = MqttServerClient(brokerUrl, 'JARVISMobile');
      client.port = brokerPort;
      client.logging(on: true);
      client.onConnected = _onConnected;
      client.onDisconnected = _onDisconnected;

      final connMess = MqttConnectMessage()
          .withClientIdentifier('JARVISMobile')
          .withWillTopic('jarvis/status')
          .withWillMessage('offline')
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);

      client.connectionMessage = connMess;
      await client.connect();
      return true;
    } catch (e) {
      logger.e('MQTT Connection Error: $e');
      return false;
    }
  }

  void _onConnected() {
    _isConnected = true;
    logger.i('MQTT Connected');
  }

  void _onDisconnected() {
    _isConnected = false;
    logger.i('MQTT Disconnected');
  }

  Future<void> controlDevice(String deviceId, String action, String value) async {
    if (!_isConnected) {
      logger.w('MQTT not connected');
      return;
    }

    try {
      final topic = 'devices/$deviceId/control';
      final message = '{"action": "$action", "value": "$value"}';
      
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
      logger.i('Device command sent: $deviceId - $action - $value');
    } catch (e) {
      logger.e('Error controlling device: $e');
    }
  }

  Future<void> disconnect() async {
    try {
      client.disconnect();
    } catch (e) {
      logger.e('Error disconnecting: $e');
    }
  }

  bool get isConnected => _isConnected;
}
