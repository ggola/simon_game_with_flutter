import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simon_game/game_manager.dart';
import 'package:simon_game/start_screen.dart';

void main() => runApp(SimonGame());

class SimonGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameManager>(
      builder: (context) => GameManager(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'PressStart2P'),
        home: StartScreen(),
      ),
    );
  }
}
