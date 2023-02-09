import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: MultiProvider(
      //   providers: const [],
      //   child: _mainUI(),
      // ),
      body: _mainUI(),
    );
  }

  Widget _mainUI() {
    return Builder(builder: (BuildContext innerContext) {
      return Scaffold();
    });
  }
}
