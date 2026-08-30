import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jarvis_mobile/providers/voice_provider.dart';
import 'package:jarvis_mobile/providers/device_provider.dart';
import 'package:jarvis_mobile/widgets/voice_button.dart';
import 'package:jarvis_mobile/widgets/device_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JARVIS'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Voice Interface
          Expanded(
            flex: 2,
            child: Consumer<VoiceProvider>(
              builder: (context, voiceProvider, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VoiceButton(
                      onPressed: () => voiceProvider.startListeningAndRespond(),
                      isListening: voiceProvider.isListening,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      voiceProvider.statusMessage,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (voiceProvider.lastTranscription.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1a1a1a),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'You said:',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                voiceProvider.lastTranscription,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (voiceProvider.lastResponse.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF252525),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade900),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'JARVIS:',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                voiceProvider.lastResponse,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          // Smart Devices
          Expanded(
            flex: 1,
            child: Consumer<DeviceProvider>(
              builder: (context, deviceProvider, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: deviceProvider.devices.length,
                  itemBuilder: (context, index) {
                    final device = deviceProvider.devices[index];
                    return DeviceCard(device: device);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
