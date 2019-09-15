import 'package:flutter/material.dart';
import 'start_screen.dart';

void main() => runApp(SimonGame());

class SimonGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'PressStart2P'),
      home: StartScreen(),
    );
  }
}
