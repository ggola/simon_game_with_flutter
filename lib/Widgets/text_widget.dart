import 'package:flutter/material.dart';
import 'package:simon_game/game_manager.dart';
import 'package:provider/provider.dart';

// Text widget
class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        Provider.of<GameManager>(context).titleHeader,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Provider.of<GameManager>(context).colorTitle, fontSize: 50),
      ),
    );
  }
}
