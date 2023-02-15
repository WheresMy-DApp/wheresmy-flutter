import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:wheresmy/providers/auth_provider.dart';
import 'package:wheresmy/providers/ble_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider _authProvider;
  late BuildContext mainContext;
  late BLEProvider _bleProvider;

  @override
  void initState() {
    BLEProvider.instance.requestPermissions().then((value) {
      BLEProvider.instance.startScan();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider.instance),
          ChangeNotifierProvider.value(value: BLEProvider.instance),
        ],
        child: _mainUI(),
      ),
    );
  }

  Widget _mainUI() {
    return Builder(builder: (BuildContext innerContext) {
      mainContext = innerContext;
      _authProvider = Provider.of<AuthProvider>(innerContext);
      _bleProvider = Provider.of<BLEProvider>(innerContext);

      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: _bleProvider.scanStatus == ScanStatus.scanning
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: _bleProvider.bleDevices.length,
                  itemBuilder: (innerContext, int index) {
                    print(_bleProvider.bleDevices[index].toString());
                    return ListTile(
                      title: Text(
                        _bleProvider.bleDevices[index].id,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        _bleProvider.bleDevices[index].macId,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        _bleProvider.bleDevices[index].rssi,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }
}