import 'package:flutter/material.dart';
import 'view/home_screen.dart';
import '../utils/themes.dart';

void main() {
  runApp(BitcoinTrackerApp());
}

class BitcoinTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Tracker',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}