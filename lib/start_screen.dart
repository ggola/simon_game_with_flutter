import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:math';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  AnimationController controllerColor;
  Animation animationColor;

  AnimationController controllerBackground;
  Animation animationBackground;

  int level = 0;
  List<String> buttonSequence = [];
  int counter = 0;

  bool tapEnabled;
  String header;
  Color backgroundColor;
  Color colorGreen;
  Color colorRed;
  Color colorYellow;
  Color colorCian;
  Color textColor;

  void reset() {
    level = 0;
    buttonSequence = [];
    counter = 0;
  }

  void startGame() {
    tapEnabled = true;
    header = 'Tap to start';
    backgroundColor = Colors.blue.shade900;
    colorGreen = Colors.green.shade700;
    colorRed = Colors.red.shade700;
    colorYellow = Colors.yellow.shade700;
    colorCian = Colors.lightBlueAccent.shade400;
    textColor = Colors.white;
  }

  void nextLevel() {
    level += 1;
    counter = 0;
    setState(() {
      header = 'Level $level';
      textColor = Colors.white;
    });
    pickButton();
  }

  void pickButton() {
    final buttonNumber = Random().nextInt(4) + 1;
    switch (buttonNumber) {
      case 1:
        displayPickedButton('green', colorGreen);
        break;
      case 2:
        displayPickedButton('red', colorRed);
        break;
      case 3:
        displayPickedButton('yellow', colorYellow);
        break;
      case 4:
        displayPickedButton('cian', colorCian);
        break;
      default:
        break;
    }
  }

  void displayPickedButton(String buttonName, Color buttonColor) {
    buttonSequence.add(buttonName);
    playSound(buttonName);
    animateColor(buttonName, buttonColor);
  }

  void playSound(String buttonName) {
    final player = AudioCache();
    player.play('$buttonName.mp3');
  }

  void animateColor(String buttonName, Color buttonColor) {
    controllerColor = AnimationController(
        vsync: this, duration: Duration(milliseconds: 200), upperBound: 1.0);
    animationColor = ColorTween(begin: buttonColor, end: Colors.white)
        .animate(controllerColor);
    controllerColor.forward();
    animationColor.addStatusListener((status) {
      // end of forward() = AnimationStatus.completed --> call .reverse()
      if (status == AnimationStatus.completed) {
        controllerColor.reverse(from: 1.0);
      }
    });
    controllerColor.addListener(() {
      switch (buttonName) {
        case 'green':
          setState(() {
            colorGreen = animationColor.value;
          });
          break;
        case 'red':
          setState(() {
            colorRed = animationColor.value;
          });
          break;
        case 'yellow':
          setState(() {
            colorYellow = animationColor.value;
          });
          break;
        case 'cian':
          setState(() {
            colorCian = animationColor.value;
          });
          break;
        default:
          break;
      }
    });
  }

  void animateBackground() {
    controllerBackground = AnimationController(
        vsync: this, duration: Duration(milliseconds: 250), upperBound: 1.0);
    animationBackground =
        ColorTween(begin: Colors.blue.shade900, end: Colors.red)
            .animate(controllerBackground);
    controllerBackground.forward();
    animationBackground.addStatusListener((status) {
      // end of forward() = AnimationStatus.completed --> call .reverse()
      if (status == AnimationStatus.completed) {
        controllerBackground.reverse(from: 1.0);
      }
    });
    controllerBackground.addListener(() {
      setState(() {
        backgroundColor = animationBackground.value;
      });
    });
  }

  void checkSelectedButton(String buttonName, Color buttonColor) {
    playSound(buttonName);
    animateColor(buttonName, buttonColor);
    checkFor(buttonPressed: buttonName);
  }

  void checkFor({String buttonPressed}) {
    counter += 1;
    final correctButton = buttonSequence[counter - 1];
    if (buttonPressed == correctButton) {
      if (counter == buttonSequence.length) {
        Future.delayed(Duration(milliseconds: 400), () {
          setState(() {
            header = 'You Hero!';
            textColor = Colors.green.shade500;
          });
          Future.delayed(Duration(milliseconds: 700), () {
            nextLevel();
          });
        });
      }
    } else {
      gameOver();
    }
  }

  void gameOver() {
    tapEnabled = true;
    playSound('wrong');
    setState(() {
      reset();
      header = 'Game over';
      textColor = Colors.red;
    });
    animateBackground();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: tapEnabled
            ? () {
                tapEnabled = false;
                Future.delayed(Duration(milliseconds: 800), () {
                  nextLevel();
                });
              }
            : null,
        child: Container(
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  header,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor, fontSize: 50),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    elevation: 5.0,
                    height: 130,
                    minWidth: 130,
                    disabledColor: colorGreen,
                    color: colorGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 4, color: Colors.black)),
                    onPressed: tapEnabled
                        ? null
                        : () {
                            checkSelectedButton('green', colorGreen);
                          },
                  ),
                  MaterialButton(
                    elevation: 5.0,
                    height: 130,
                    minWidth: 130,
                    disabledColor: colorRed,
                    color: colorRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 4, color: Colors.black)),
                    onPressed: tapEnabled
                        ? null
                        : () {
                            checkSelectedButton('red', colorRed);
                          },
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    elevation: 5.0,
                    height: 130,
                    minWidth: 130,
                    disabledColor: colorYellow,
                    color: colorYellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 4, color: Colors.black)),
                    onPressed: tapEnabled
                        ? null
                        : () {
                            checkSelectedButton('yellow', colorYellow);
                          },
                  ),
                  MaterialButton(
                    elevation: 5.0,
                    height: 130,
                    minWidth: 130,
                    disabledColor: colorCian,
                    color: colorCian,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 4, color: Colors.black)),
                    onPressed: tapEnabled
                        ? null
                        : () {
                            checkSelectedButton('cian', colorCian);
                          },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
