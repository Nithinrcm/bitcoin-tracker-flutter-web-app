import 'package:flutter/material.dart';
import 'view/home_screen.dart';

void main() {
  runApp(BitcoinTrackerApp());
}

class BitcoinTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
    );
  }
}
