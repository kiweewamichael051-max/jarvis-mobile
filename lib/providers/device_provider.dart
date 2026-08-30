import 'package:flutter/material.dart';
import 'package:jarvis_mobile/services/device_control_service.dart';

class SmartDevice {
  final String id;
  final String name;
  final String type; // light, thermostat, switch, etc.
  bool isOn;
  int? brightness;
  int? temperature;

  SmartDevice({
    required this.id,
    required this.name,
    required this.type,
    this.isOn = false,
    this.brightness,
    this.temperature,
  });
}

class DeviceProvider extends ChangeNotifier {
  final DeviceControlService _deviceControlService = DeviceControlService();
  
  List<SmartDevice> _devices = [];
  bool _isConnected = false;

  DeviceProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isConnected = await _deviceControlService.connectToMQTT();
    _loadMockDevices();
    notifyListeners();
  }

  void _loadMockDevices() {
    _devices = [
      SmartDevice(
        id: 'light_1',
        name: 'Living Room Light',
        type: 'light',
        isOn: false,
        brightness: 50,
      ),
      SmartDevice(
        id: 'thermostat_1',
        name: 'Thermostat',
        type: 'thermostat',
        temperature: 72,
      ),
      SmartDevice(
        id: 'switch_1',
        name: 'Front Door Lock',
        type: 'switch',
        isOn: false,
      ),
    ];
  }

  Future<void> toggleDevice(String deviceId) async {
    final device = _devices.firstWhere((d) => d.id == deviceId);
    device.isOn = !device.isOn;
    
    await _deviceControlService.controlDevice(
      deviceId,
      'toggle',
      device.isOn ? 'on' : 'off',
    );
    notifyListeners();
  }

  Future<void> setBrightness(String deviceId, int brightness) async {
    final device = _devices.firstWhere((d) => d.id == deviceId);
    device.brightness = brightness;
    
    await _deviceControlService.controlDevice(
      deviceId,
      'set_brightness',
      brightness.toString(),
    );
    notifyListeners();
  }

  Future<void> setTemperature(String deviceId, int temperature) async {
    final device = _devices.firstWhere((d) => d.id == deviceId);
    device.temperature = temperature;
    
    await _deviceControlService.controlDevice(
      deviceId,
      'set_temperature',
      temperature.toString(),
    );
    notifyListeners();
  }

  List<SmartDevice> get devices => _devices;
  bool get isConnected => _isConnected;
}
