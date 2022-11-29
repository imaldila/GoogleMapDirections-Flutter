import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_directions/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.376854, -122.028842);
  static const LatLng destination =
      LatLng(37.37380254652253, -122.02908244479785);

  List<LatLng> polylinesCoordinates = [];

  void getPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    print(result);

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylinesCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    } else {
      print('Empty');
    }
  }

  @override
  void initState() {
    getPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(polylinesCoordinates);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoogleMap Directions'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: sourceLocation, zoom: 13.4746),
        polylines: {
          Polyline(
            polylineId: const PolylineId('source'),
            points: polylinesCoordinates,
            color: Colors.blue,
            width: 6,
          ),
        },
        markers: {
          const Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
        onMapCreated: (map) => _controller.complete(map),
      ),
    );
  }
}
