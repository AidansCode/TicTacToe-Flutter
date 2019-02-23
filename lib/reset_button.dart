import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_control.dart';

class ResetButton extends StatelessWidget {

  GameControl gameControl;

  ResetButton(this.gameControl);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Reset Game', style: TextStyle(color: Colors.white)),
      color: Colors.red,
      onPressed: () => gameControl.confirmResetGame(),
    );
  }

}