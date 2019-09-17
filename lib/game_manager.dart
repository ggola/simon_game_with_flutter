import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:math';

class GameManager extends ChangeNotifier {
  Color _colorGreen = Colors.green.shade700;
  Color _colorRed = Colors.red.shade700;
  Color _colorYellow = Colors.yellow.shade700;
  Color _colorCian = Colors.lightBlueAccent.shade400;
  Color _colorBackground = Colors.blue.shade900;

  int _level = 0;
  List<String> _buttonSequence = [];
  int _counter = 0;

  bool _tapEnabled = true;
  String _header = 'Tap to start';
  Color _titleColor = Colors.white;

  String get titleHeader {
    return _header;
  }

  Color get colorTitle {
    return _titleColor;
  }

  Color get colorGreen {
    return _colorGreen;
  }

  Color get colorRed {
    return _colorRed;
  }

  Color get colorYellow {
    return _colorYellow;
  }

  Color get colorCian {
    return _colorCian;
  }

  Color get colorBackground {
    return _colorBackground;
  }

  void screenTapped() {
    if (_tapEnabled) {
      _tapEnabled = false;
      Future.delayed(Duration(milliseconds: 800), () {
        _nextLevel();
      });
    }
    notifyListeners();
  }

  bool get tapEnabledState {
    return _tapEnabled;
  }

  void _nextLevel() {
    _level += 1;
    _counter = 0;
    _header = 'Level $_level';
    _titleColor = Colors.white;
    notifyListeners();
    _pickButton();
  }

  void _pickButton() {
    final buttonNumber = Random().nextInt(4) + 1;
    switch (buttonNumber) {
      case 1:
        _displayPickedButton('green', _colorGreen);
        break;
      case 2:
        _displayPickedButton('red', _colorRed);
        break;
      case 3:
        _displayPickedButton('yellow', _colorYellow);
        break;
      case 4:
        _displayPickedButton('cian', _colorCian);
        break;
      default:
        break;
    }
  }

  void _displayPickedButton(String buttonName, Color buttonColor) {
    _buttonSequence.add(buttonName);
    _playSound(buttonName);
    _animateButtonColor(buttonName);
  }

  void _playSound(String buttonName) {
    final player = AudioCache();
    player.play('$buttonName.mp3');
  }

  void _animateButtonColor(String buttonName) {
    switch (buttonName) {
      case 'green':
        _colorGreen = Colors.white;
        notifyListeners();
        Future.delayed(Duration(milliseconds: 250), () {
          _colorGreen = Colors.green.shade700;
          notifyListeners();
        });

        break;
      case 'red':
        _colorRed = Colors.white;
        notifyListeners();
        Future.delayed(Duration(milliseconds: 250), () {
          _colorRed = Colors.red.shade700;
          notifyListeners();
        });

        break;
      case 'yellow':
        _colorYellow = Colors.white;
        notifyListeners();
        Future.delayed(Duration(milliseconds: 250), () {
          _colorYellow = Colors.yellow.shade700;
          notifyListeners();
        });

        break;
      case 'cian':
        _colorCian = Colors.white;
        notifyListeners();
        Future.delayed(Duration(milliseconds: 250), () {
          _colorCian = Colors.lightBlueAccent.shade400;
          notifyListeners();
        });

        break;
      default:
        break;
    }
  }

  void buttonPressed({String buttonName, Color buttonColor}) {
    if (!_tapEnabled) {
      _checkSelectedButton(buttonName, buttonColor);
      notifyListeners();
    }
  }

  void _checkSelectedButton(String buttonName, Color buttonColor) {
    _playSound(buttonName);
    _animateButtonColor(buttonName);
    _checkFor(buttonPressed: buttonName);
  }

  void _checkFor({String buttonPressed}) {
    _counter += 1;
    final correctButton = _buttonSequence[_counter - 1];
    if (buttonPressed == correctButton) {
      if (_counter == _buttonSequence.length) {
        Future.delayed(Duration(milliseconds: 400), () {
          _header = 'You Hero!';
          _titleColor = Colors.green.shade500;
          notifyListeners();
          Future.delayed(Duration(milliseconds: 700), () {
            _nextLevel();
          });
        });
      }
    } else {
      _gameOver();
    }
  }

  void _gameOver() {
    _playSound('wrong');
    _tapEnabled = true;
    _header = 'Game over';
    _titleColor = Colors.red;
    notifyListeners();
    _animateBackground();
    _resetGame();
  }

  void _animateBackground() {
    _colorBackground = Colors.red;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 250), () {
      _colorBackground = Colors.blue.shade900;
      notifyListeners();
    });
  }

  void _resetGame() {
    _level = 0;
    _buttonSequence = [];
    _counter = 0;
  }
}
