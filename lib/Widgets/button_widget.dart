import 'package:flutter/material.dart';
import 'package:simon_game/game_manager.dart';
import 'package:provider/provider.dart';

// Button
class ButtonWidget extends StatelessWidget {
  final String name;
  final Color color;
  final Color variableColor;
  ButtonWidget(
      {@required this.name,
      @required this.color,
      @required this.variableColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5.0,
      height: 130,
      minWidth: 130,
      disabledColor: variableColor,
      color: variableColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(width: 4, color: Colors.black)),
      onPressed: () {
        Provider.of<GameManager>(context)
            .buttonPressed(buttonName: name, buttonColor: color);
      },
    );
  }
}
