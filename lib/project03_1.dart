import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Tic tac toe!"),
        ),
        body: TicTacToe(),
      ),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  ///vars
  Color _color = Colors.deepPurple;
  List<Color> _colors = new List(9);
  List<int> _winning = new List();
  bool _visiblePlay = false;

  ///#vars

  ///methods
  void initState() {
    super.initState();
    for (int i = 0; i < 9; i++) _colors[i] = Colors.white10;
    _visiblePlay = false;
  }

  void initGame() {
    setState(() {
      for (int i = 0; i < 9; i++) _colors[i] = Colors.white10;
      _visiblePlay = false;
    });
  }

  void pressed(int index) {
    setState(() {
      _colors[index] = _color;
      if (_color == Colors.deepPurple)
        _color = Colors.lightGreenAccent;
      else
        _color = Colors.deepPurple;
    });
  }

  int numberOfXO() {
    int count = 0;
    for (int i = 0; i < 9; i++) {
      if (_colors[i] != Colors.white10) count++;
    }
    return count;
  }

  bool checkWin() {
    if (_colors[0] == _colors[3] && _colors[3] == _colors[6] && _colors[0] != Colors.white10) {
      _winning.addAll([0, 3, 6]);
      return true;
    } else if (_colors[1] == _colors[4] && _colors[4] == _colors[7] && _colors[1] != Colors.white10) {
      _winning.addAll([1, 4, 7]);
      return true;
    } else if (_colors[2] == _colors[5] && _colors[5] == _colors[8] && _colors[2] != Colors.white10) {
      _winning.addAll([2, 5, 8]);
      return true;
    } else if (_colors[0] == _colors[1] && _colors[1] == _colors[2] && _colors[0] != Colors.white10) {
      _winning.addAll([0, 1, 2]);
      return true;
    } else if (_colors[3] == _colors[4] && _colors[4] == _colors[5] && _colors[3] != Colors.white10) {
      _winning.addAll([3, 4, 5]);
      return true;
    } else if (_colors[6] == _colors[7] && _colors[7] == _colors[8] && _colors[6] != Colors.white10) {
      _winning.addAll([6, 7, 8]);
      return true;
    } else if (_colors[0] == _colors[4] && _colors[4] == _colors[8] && _colors[0] != Colors.white10) {
      _winning.addAll([0, 4, 8]);
      return true;
    } else if (_colors[2] == _colors[4] && _colors[4] == _colors[6] && _colors[2] != Colors.white10) {
      _winning.addAll([2, 4, 6]);
      return true;
    } else
      return false;
  }

  void playOrRestart() {
    if (checkWin()) {
      setState(() {
        for (int i = 0; i < 9; i++) {
          if (_winning.contains(i) == false) _colors[i] = Colors.white10;
        }
        _winning.clear();
        _visiblePlay = true;
      });
    } else if (numberOfXO() == 9)
      setState(() {
        _visiblePlay = true;
      });
  }

  ///#methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          GridView.builder(
            itemCount: 9,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return AnimatedContainer(
                onEnd: playOrRestart,
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.teal,
                    width: 0.4,
                  ),
                  color: _colors[index],
                ),
                child: FlatButton(
                  onPressed: () {
                    pressed(index);
                  },
                  child: null,
                ),
              );
            },
          ),
          const SizedBox(
            height: 35,
          ),
          Visibility(
            visible: _visiblePlay,
            child: FlatButton(
              onPressed: initGame,
              child: Text("Play again!"),
            ),
          ),
        ],
      ),
    );
  }
}

/*
GridView.count(
        padding: EdgeInsets.all(2),
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: List.generate(
          9,
          (index) {
            return AnimatedContainer(
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.teal,
                  width: 0.4,
                ),
                color: colors[index],
              ),
              child: FlatButton(
                onPressed: () {
                  pressed(index);
                },
                child: null,
              ),
            );
          },
        ),
      ),
 */
