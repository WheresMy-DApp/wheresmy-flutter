import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterBlue flutterBlue;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    flutterBlue = FlutterBlue.instance;
  }

  void _requestPermission() async {
    List<Permission> permissions = [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth
    ];
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    // If all statuses are granted, then the app can perform the task.
    // If any status is denied, then the app cannot perform the task.
    for (int i = 0; i < statuses.length; i++) {
      print(statuses[permissions[i]]);
      if (statuses[permissions[i]] != PermissionStatus.granted) {
        print('Permission denied');
        return;
      }
    }
    flutterBlue.startScan(timeout: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Where\'s My'),
        ),
        body: Center(
            child: StreamBuilder<List<ScanResult>>(
          stream: FlutterBlue.instance.scanResults,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (content, int index) {
                  return ListTile(
                    title: Text(snapshot.data![index].device.name),
                    subtitle: Text(snapshot.data![index].device.id.toString()),
                    trailing: Text(snapshot.data![index].rssi.toString()),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
          // builder: (c, snapshot) => Column(
          //   children: snapshot.data!
          //       .map(
          //         (r) => Text(r.device.name),
          //       )
          //       .toList(),
          // ),
        )),
      ),
    );
  }
}
