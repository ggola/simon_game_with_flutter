import 'package:flutter/material.dart';
import 'package:simon_game/game_manager.dart';
import 'package:provider/provider.dart';
import 'package:simon_game/Widgets/background_widget.dart';

// Scaffold and Gesture Detector
class GestureDetectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<GameManager>(context).screenTapped();
        },
        child: BackgroundWidget());
  }
}
