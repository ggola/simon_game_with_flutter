import 'package:flutter/material.dart';
import 'package:simon_game/game_manager.dart';
import 'package:provider/provider.dart';
import 'package:simon_game/Widgets/button_widget.dart';
import 'package:simon_game/Widgets/text_widget.dart';

// Column with title and buttons
class ColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextWidget(),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonWidget(
                name: 'green',
                color: Colors.green.shade700,
                variableColor: Provider.of<GameManager>(context).colorGreen),
            ButtonWidget(
                name: 'red',
                color: Colors.red.shade700,
                variableColor: Provider.of<GameManager>(context).colorRed),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonWidget(
                name: 'yellow',
                color: Colors.yellow.shade700,
                variableColor: Provider.of<GameManager>(context).colorYellow),
            ButtonWidget(
                name: 'cian',
                color: Colors.lightBlueAccent.shade400,
                variableColor: Provider.of<GameManager>(context).colorCian),
          ],
        ),
      ],
    );
  }
}
