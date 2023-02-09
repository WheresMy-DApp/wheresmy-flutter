import 'package:flutter/material.dart';
import 'package:wheresmy/pages/landing/index.dart';
import 'package:wheresmy/pages/register/index.dart';
import 'package:wheresmy/pages/sign_in/index.dart';
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
  // Theme Constants

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Where's My",
      theme: ThemeData(
        backgroundColor: const Color(0x00078dce),
        fontFamily: "Avenir NextLT",
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
          headline5: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(
            0xFF191919,
          ),
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
      ),
      routes: {
        "splash": (context) => const SplashScreen(),
        "landing": (context) => const LandingPage(),
        "sign_in": (context) => const SignInPage(),
        "register": (context) => const RegisterPage(),
      },
      initialRoute: "splash",
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
