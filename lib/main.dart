import 'package:flutter/material.dart';
import 'package:googlemap_directions/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Google Map Directions',
      home: MapScreen(),
    );
  }
}
