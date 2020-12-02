import 'dart:math';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            "|Number Shapes|",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: MyStateFull(),
      ),
    );
  }
}

class MyStateFull extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyStateFull> {
  ///variables
  TextEditingController _controller = new TextEditingController();
  int _enteredNumber = 0;
  String _conclusion = "";

  ///#variables

  ///methods
  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Ok."),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        _enteredNumber.toString(),
      ),
      content: Text(
        _conclusion,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  bool isSquare(int value) {
    int counter = 0;
    while (pow(counter, 2) < value) counter++;
    if (pow(counter, 2) == value) return true;
    return false;
  }

  bool isTriangular(int value) {
    int counter = 0;
    while (pow(counter, 3) < value) counter++;
    if (pow(counter, 3) == value) return true;
    return false;
  }

  void update() {
    setState(() {
      _controller.clear();
      if (isSquare(_enteredNumber) && isTriangular(_enteredNumber)) {
        _conclusion = "The number " + _enteredNumber.toString() + " is a square and a triangular.";
      } else if (isSquare(_enteredNumber)) {
        _conclusion = "The number " + _enteredNumber.toString() + " is a square.";
      } else if (isTriangular(_enteredNumber)) {
        _conclusion = "The number " + _enteredNumber.toString() + " is a triangular.";
      } else {
        _conclusion = "The number " + _enteredNumber.toString() + " is neither a square nor a triangular.";
      }
    });
  }

  ///#methods

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Text(
              "Enter a number to see if it is square or triangular.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                _enteredNumber = int.parse(value);
              },
            ),
            SizedBox(
              height: 270,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  update();
                  showAlertDialog(context);
                },
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.check_circle_outline_sharp,
                  color: Colors.teal,
                ),
              ),
            )
          ],
        ));
  }
}
