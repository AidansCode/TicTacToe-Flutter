import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_button.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }

}

class _HomePageState extends State<HomePage> {

  List<GameButton> _buttons;
  bool _xTurn, _processingMove;
  int _moveCount;

  @override
  void initState() {
    super.initState();

    resetState();
  }

  void resetState() {
    setState(() {
      _buttons = [
        GameButton(id: 0), GameButton(id: 1), GameButton(id: 2),
        GameButton(id: 3), GameButton(id: 4), GameButton(id: 5),
        GameButton(id: 6), GameButton(id: 7), GameButton(id: 8)
      ];
      _xTurn = true;
      _moveCount = 0;
      _processingMove = false;
    });
  }

  void checkGameStatus() {
    //check columns
    for (int i = 0; i < 3; i++) {
      if (_buttons[i].enabled == false && _buttons[i].text == _buttons[i+3].text && _buttons[i].text == _buttons[i+6].text) {
        _buttons[i].bg = Colors.green;
        _buttons[i+3].bg = Colors.green;
        _buttons[i+6].bg = Colors.green;

        endGame(hasWinner: true, winner: _buttons[i].text);
        return;
      }
    }

    //check rows
    for (int i = 0; i < 7; i += 3) {
      if (_buttons[i].enabled == false && _buttons[i].text == _buttons[i+1].text && _buttons[i].text == _buttons[i+2].text) {
        _buttons[i].bg = Colors.green;
        _buttons[i+1].bg = Colors.green;
        _buttons[i+2].bg = Colors.green;

        endGame(hasWinner: true, winner: _buttons[i].text);
        return;
      }
    }

    //check diagonal down -> right
    if (_buttons[0].enabled == false && _buttons[0].text == _buttons[4].text && _buttons[0].text == _buttons[8].text) {
      _buttons[0].bg = Colors.green;
      _buttons[4].bg = Colors.green;
      _buttons[8].bg = Colors.green;

      endGame(hasWinner: true, winner: _buttons[0].text);
      return;
    }

    //check diagonal up -> right
    if (_buttons[2].enabled == false && _buttons[2].text == _buttons[4].text && _buttons[2].text == _buttons[6].text) {
      _buttons[2].bg = Colors.green;
      _buttons[4].bg = Colors.green;
      _buttons[6].bg = Colors.green;

      endGame(hasWinner: true, winner: _buttons[2].text);
      return;
    }

    if (_moveCount == 9) {
      for (int i = 0; i < 9; i++) {
        _buttons[i].bg = Colors.yellow;
      }
      endGame(hasWinner: false);
    }
  }

  void endGame({bool hasWinner, String winner = ""}) {
    for (int i = 0; i < 9; i++) {
      _buttons[i].enabled = false;
    }
    //Run after 1000 milliseconds (1 second)
    Future.delayed(Duration(milliseconds: 1000), () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('The game as ended!'),
              content: Text(hasWinner ? "Player \"" + winner + "\" has won the game!" : "The game ended in a tie..."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      resetState();
                      Navigator.pop(context);
                    },
                    child: Text('Reset Game')
                )
              ],
            );
          }
      );
    });
  }

  void confirmResetGame() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reset Game!'),
            content: Text("Are you sure you want to reset the game?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    resetState();
                    Navigator.pop(context);
                  },
                  child: Text('Reset Game', style: TextStyle(color: Colors.white)),
                  color: Colors.red
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')
              )
            ],
          );
        }
    );
  }

  void choosePosition(GameButton gB) {
    _processingMove = true;
    print("Now processing " + gB.id.toString());
    setState(() {
      gB.text = _xTurn ? "×" : "O";
      gB.bg = _xTurn ? Colors.red : Colors.blue;
      gB.enabled = false;

      _xTurn = !_xTurn;
      _moveCount++;
    });

    checkGameStatus();
    _processingMove = false;
    print("Done processing " + gB.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tic Tac Toe')
      ),
      body: Column(
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0
                ),
                itemCount: _buttons.length,
                itemBuilder: (context, i) => new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      onPressed: () {
                        print("Attempting to select $i");
                        if (!_processingMove && _buttons[i].enabled) {
                          choosePosition(_buttons[i]);
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
            ),
            RaisedButton(
              child: Text('Reset Game', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              onPressed: () => confirmResetGame(),
            )
          ],
      )
    );
  }

}