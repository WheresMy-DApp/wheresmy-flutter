import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FlutterBlue flutterBlue = FlutterBlue.instance;
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
