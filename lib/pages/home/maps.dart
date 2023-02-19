import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wheresmy/providers/maps_provider.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late MapsProvider _mapsProvider;

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: MapsProvider.instance),
        ],
        child: _mainUI(),
      ),
    );
  }

  Widget _mainUI() {
    return Builder(builder: (BuildContext innerContext) {
      _mapsProvider = Provider.of<MapsProvider>(innerContext);
      return _mapsProvider.isCurrentPositionLocated
          ? GoogleMap(
              myLocationEnabled: true,
              markers: {
                Marker(
                  markerId: const MarkerId('currentPosition'),
                  position: LatLng(
                    _mapsProvider.currentPosition!.latitude,
                    _mapsProvider.currentPosition!.longitude,
                  ),
                ),
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _mapsProvider.currentPosition!.latitude,
                  _mapsProvider.currentPosition!.longitude,
                ),
                zoom: 14.4746,
              ),
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
