import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheresmy/services/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      NavigationService.instance.navigateToReplacement("landing");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0x00013ba8),
      body: Center(
        child: Image(
          image: AssetImage("assets/logos/splash.png"),
          width: 216,
          height: 216,
        ),
      ),
    );
  }
}
