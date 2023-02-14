import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheresmy/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider _authProvider;
  late BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider.instance),
        ],
        child: _mainUI(),
      ),
    );
  }

  Widget _mainUI() {
    return Builder(builder: (BuildContext innerContext) {
      mainContext = innerContext;
      _authProvider = Provider.of<AuthProvider>(innerContext);

      return const Scaffold(
        body: Center(
          child: Text("Home Page"),
        ),
      );
    });
  }
}
