import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:jarvis_mobile/providers/voice_provider.dart';
import 'package:jarvis_mobile/providers/device_provider.dart';
import 'package:jarvis_mobile/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const JarvisMobileApp());
}

class JarvisMobileApp extends StatelessWidget {
  const JarvisMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VoiceProvider()),
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
      ],
      child: MaterialApp(
        title: 'JARVIS Mobile',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF1a1a1a),
          scaffoldBackgroundColor: const Color(0xFF0d0d0d),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
