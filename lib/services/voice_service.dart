import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';

class VoiceService {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final logger = Logger();

  bool _isListening = false;

  Future<void> initializeSpeechRecognition() async {
    try {
      bool available = await _speechToText.initialize(
        onError: (error) => logger.e('Error: $error'),
        onStatus: (status) => logger.i('Status: $status'),
      );
      if (!available) {
        logger.e('Speech recognition not available on this device');
      }
    } catch (e) {
      logger.e('Error initializing speech recognition: $e');
    }
  }

  Future<void> initializeTTS() async {
    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.5);
    } catch (e) {
      logger.e('Error initializing TTS: $e');
    }
  }

  Future<String> startListening() async {
    String result = '';
    if (!_isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        _isListening = true;
        _speechToText.listen(
          onResult: (value) {
            result = value.recognizedWords;
          },
        );
      } else {
        logger.e('Speech recognition not available');
      }
    }
    return result;
  }

  Future<void> stopListening() async {
    if (_isListening) {
      _isListening = false;
      await _speechToText.stop();
    }
  }

  Future<void> speak(String text) async {
    try {
      await _flutterTts.speak(text);
    } catch (e) {
      logger.e('Error speaking: $e');
    }
  }

  bool get isListening => _isListening;
}
