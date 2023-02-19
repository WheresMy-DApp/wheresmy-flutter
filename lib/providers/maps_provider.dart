import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapsProvider extends ChangeNotifier {
  Position? currentPosition;
  bool isCurrentPositionLocated = false;

  static MapsProvider instance = MapsProvider();

  MapsProvider();

  Future<void> getCurrentPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    isCurrentPositionLocated = true;
    notifyListeners();
  }
}
