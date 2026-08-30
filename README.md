# JARVIS Mobile

A cross-platform mobile voice assistant built with Flutter, featuring OpenAI integration and smart device control.

## Features

- **Voice Input/Output**: Speak to JARVIS and get spoken responses
- **AI-Powered**: Powered by OpenAI's GPT-4 for intelligent conversations
- **Smart Device Control**: Control IoT devices via MQTT protocol
- **Cross-Platform**: Runs on both iOS and Android
- **Real-time Processing**: Fast voice recognition and response generation

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK (included with Flutter)
- OpenAI API key
- (Optional) MQTT broker for smart device control

## Installation

1. Clone the repository:
```bash
git clone https://github.com/kiweewamichael051-max/jarvis-mobile.git
cd jarvis-mobile
```

2. Get dependencies:
```bash
flutter pub get
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env and add your OpenAI API key
```

4. Run the app:
```bash
flutter run
```

## Configuration

### OpenAI Setup
1. Get your API key from [OpenAI Platform](https://platform.openai.com)
2. Add it to your `.env` file

### Smart Device Control
1. Set up an MQTT broker (e.g., Mosquitto)
2. Configure broker details in `.env`
3. Connect compatible IoT devices to the broker

## Project Structure

```
lib/
├── main.dart              # App entry point
├── screens/               # UI screens
│   └── home_screen.dart   # Main interface
├── services/              # Business logic
│   ├── voice_service.dart         # Speech recognition & TTS
│   ├── openai_service.dart        # OpenAI API integration
│   └── device_control_service.dart # Smart device control
├── providers/             # State management
│   ├── voice_provider.dart   # Voice state
│   └── device_provider.dart  # Device state
└── widgets/               # Reusable UI components
    ├── voice_button.dart     # Voice interaction button
    └── device_card.dart      # Device control card
```

## Usage

1. **Start Voice Interaction**:
   - Tap the blue microphone button
   - Speak your command or question
   - JARVIS will respond with voice feedback

2. **Control Devices**:
   - View connected smart devices
   - Toggle devices on/off using the switches
   - Adjust settings (brightness, temperature) as needed

3. **Natural Commands**:
   - "Turn on the living room light"
   - "Set thermostat to 72 degrees"
   - "What's the weather?"
   - "Lock the front door"

## API Integration

### OpenAI API
- Model: GPT-4
- Temperature: 0.7
- Max Tokens: 150
- System Role: JARVIS assistant persona

### MQTT Topics
- Command: `devices/{device_id}/control`
- Status: `jarvis/status`
- Subscribe: `devices/{device_id}/status`

## Technologies

- **Flutter**: Cross-platform mobile framework
- **Dart**: Programming language
- **OpenAI API**: AI responses and natural language processing
- **Speech-to-Text**: Voice input recognition
- **Flutter TTS**: Text-to-speech output
- **MQTT**: IoT device communication
- **Provider**: State management

## Development

### Building for iOS
```bash
flutter build ios
```

### Building for Android
```bash
flutter build apk
```

### Running Tests
```bash
flutter test
```

## Troubleshooting

### Microphone Permission Denied
- iOS: Add microphone permissions to `ios/Runner/Info.plist`
- Android: Grant microphone permission in app settings

### OpenAI API Errors
- Verify API key in `.env` file
- Check API usage limits
- Ensure internet connection

### Speech Recognition Not Working
- Ensure microphone is enabled
- Check language settings
- Test with system voice apps first

## Future Enhancements

- [ ] Multi-language support
- [ ] Custom wake word detection
- [ ] Advanced gesture controls
- [ ] Home automation routines
- [ ] Offline mode with local LLM
- [ ] Real-time device status monitoring
- [ ] User authentication
- [ ] Cloud sync across devices

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues.

## License

MIT License - see LICENSE file for details

## Author

Kiweewa Michael

## Support

For issues or questions, please open an issue on GitHub.
