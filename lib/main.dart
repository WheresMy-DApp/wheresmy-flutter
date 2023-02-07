import 'package:flutter/material.dart';
import 'package:wheresmy/pages/landing/index.dart';
import 'package:wheresmy/pages/login/index.dart';
import 'package:wheresmy/pages/splash/index.dart';
import 'package:wheresmy/services/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Where's My",
      routes: {
        "splash": (context) => const SplashScreen(),
        "login": (context) => const LoginPage(),
        "landing": (context) => const LandingPage(),
      },
      initialRoute: "splash",
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
