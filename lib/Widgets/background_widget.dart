import 'package:flutter/material.dart';
import 'package:simon_game/game_manager.dart';
import 'package:provider/provider.dart';
import 'package:simon_game/Widgets/column_widget.dart';

// Container with Background
class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Provider.of<GameManager>(context).colorBackground,
      child: ColumnWidget(),
    );
  }
}
