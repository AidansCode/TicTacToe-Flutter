import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {

  var _home;

  GameBoard(this._home);

  @override
  Widget build(BuildContext context) {
    var _buttons = _home.buttons;

    return Expanded(
        child: GridView.builder(
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 9.0,
              mainAxisSpacing: 9.0
          ),
          itemCount: _home.buttons.length,
          itemBuilder: (context, i) => new SizedBox(
              width: 100.0,
              height: 100.0,
              child: RaisedButton(
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  if (!_home.gameControl.isProcessingMove && _buttons[i].enabled) {
                    _home.gameControl.choosePosition(_buttons[i]);
                  }
                },
                child: Text(
                    _buttons[i].text,
                    style: new TextStyle(color: Colors.white, fontSize: 100.0)
                ),
                color: _buttons[i].bg,
                disabledColor: _buttons[i].bg,
              )
          ),
        )
    );
  }

}