import 'package:flutter/material.dart';
import 'package:jarvis_mobile/services/voice_service.dart';
import 'package:jarvis_mobile/services/openai_service.dart';

class VoiceProvider extends ChangeNotifier {
  final VoiceService _voiceService = VoiceService();
  final OpenAIService _openAIService = OpenAIService();

  bool _isListening = false;
  bool _isProcessing = false;
  String _lastTranscription = '';
  String _lastResponse = '';
  String _statusMessage = 'Ready to listen';

  VoiceProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _voiceService.initializeSpeechRecognition();
    await _voiceService.initializeTTS();
  }

  Future<void> startListeningAndRespond() async {
    _isListening = true;
    _statusMessage = 'Listening...';
    notifyListeners();

    try {
      final transcription = await _voiceService.startListening();
      _lastTranscription = transcription;
      
      await _voiceService.stopListening();
      _isListening = false;
      _isProcessing = true;
      _statusMessage = 'Processing...';
      notifyListeners();

      final response = await _openAIService.generateResponse(transcription);
      _lastResponse = response;
      
      await _voiceService.speak(response);
      _isProcessing = false;
      _statusMessage = 'Ready to listen';
    } catch (e) {
      _statusMessage = 'Error: $e';
      _isListening = false;
      _isProcessing = false;
    }
    notifyListeners();
  }

  void stopListening() async {
    await _voiceService.stopListening();
    _isListening = false;
    notifyListeners();
  }

  bool get isListening => _isListening;
  bool get isProcessing => _isProcessing;
  String get lastTranscription => _lastTranscription;
  String get lastResponse => _lastResponse;
  String get statusMessage => _statusMessage;
}
