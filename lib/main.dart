import 'package:app_maps/pages/start_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

//CRISTIAN EULISES SANCHEZ RAMIREZ 
//2021-1899
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InfoLocation(),
    );
  }
}
