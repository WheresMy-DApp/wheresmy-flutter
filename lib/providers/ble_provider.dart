import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

enum ScanStatus {
  scanning,
  stopped,
}

class BLEDevice {
  final String id;
  final String macId;
  final String rssi;

  BLEDevice({
    required this.id,
    required this.macId,
    required this.rssi,
  });

  factory BLEDevice.fromScanResult(ScanResult scanResult) {
    return BLEDevice(
      id: scanResult.device.id.id,
      macId: scanResult.device.id.id,
      rssi: scanResult.rssi.toString(),
    );
  }

  @override
  String toString() {
    return 'BLEDevice{id: $id, macId: $macId, rssi: $rssi}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'macId': macId,
      'rssi': rssi,
    };
  }
}

class BLEProvider extends ChangeNotifier {
  ScanStatus scanStatus = ScanStatus.stopped;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BLEDevice> bleDevices = [];

  static BLEProvider instance = BLEProvider();

  BLEProvider();

  Future<void> requestPermissions() async {
    List<Permission> permissions = [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth
    ];

    Map<Permission, PermissionStatus> statuses = await permissions.request();
    for (int i = 0; i < statuses.length; i++) {
      if (statuses[permissions[i]] != PermissionStatus.granted) {
        return;
      }
    }
  }

  void startScan() {
    scanStatus = ScanStatus.scanning;
    notifyListeners();
    flutterBlue.startScan(timeout: const Duration(seconds: 4)).then((value) {
      stopScan();
    });
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name == 'WheresMy') {
          bleDevices.add(BLEDevice(
            id: r.device.name,
            macId: r.device.id.id,
            rssi: r.rssi.toString(),
          ));
        }
      }
    });
  }

  void stopScan() {
    scanStatus = ScanStatus.stopped;
    notifyListeners();
    FlutterBlue.instance.stopScan();
  }
}
