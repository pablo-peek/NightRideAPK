import 'package:flutter/material.dart';
import './pages/home.dart';

void main() {
  runApp(const NightRide());
}

class NightRide extends StatelessWidget {
  const NightRide({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}