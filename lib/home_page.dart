import 'package:flutter/material.dart';
import 'package:tic_tac_toe/reset_button.dart';
import 'game_button.dart';
import 'game_control.dart';
import 'game_board.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }

}

class _HomePageState extends State<HomePage> {

  GameControl _gameControl;
  List<GameButton> _buttons;

  @override
  void initState() {
    super.initState();

    _gameControl = GameControl(this);

    _gameControl.resetState();
  }

  void callback(Function() execute) {
    setState(() {
      execute();
    });
  }

  List<GameButton> get buttons => _buttons;
  GameControl get gameControl => _gameControl;
  set buttons(List<GameButton> newButtons) {
    _buttons = newButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tic Tac Toe')
      ),
      body: Column(
          children: <Widget>[
            GameBoard(this),
            ResetButton(_gameControl)
          ],
      )
    );
  }

}