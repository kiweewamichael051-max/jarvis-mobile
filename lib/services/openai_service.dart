import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class OpenAIService {
  final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  final String _baseUrl = 'https://api.openai.com/v1';
  final logger = Logger();

  Future<String> generateResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4',
          'messages': [
            {
              'role': 'system',
              'content': 'You are JARVIS, an intelligent voice assistant. You help control smart home devices and answer questions. Keep responses concise and professional.'
            },
            {
              'role': 'user',
              'content': prompt
            }
          ],
          'temperature': 0.7,
          'max_tokens': 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        logger.e('OpenAI API Error: ${response.statusCode}');
        return 'I encountered an error processing your request.';
      }
    } catch (e) {
      logger.e('Error: $e');
      return 'Connection error. Please try again.';
    }
  }
}
