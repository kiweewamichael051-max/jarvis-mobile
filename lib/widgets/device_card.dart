import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jarvis_mobile/providers/device_provider.dart';

class DeviceCard extends StatelessWidget {
  final SmartDevice device;

  const DeviceCard({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: device.isOn ? Colors.blue : Colors.grey.shade700,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                device.isOn ? 'On' : 'Off',
                style: TextStyle(
                  color: device.isOn ? Colors.blue : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Switch(
            value: device.isOn,
            onChanged: (_) {
              context.read<DeviceProvider>().toggleDevice(device.id);
            },
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
