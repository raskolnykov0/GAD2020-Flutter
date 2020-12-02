import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TapBoxA extends StatefulWidget {
  TapBoxA({Key key}) : super(key: key);

  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  double money = 0.0;
  double convertedMoney = 0.0;
  bool validInput = true;
  final TextEditingController control = new TextEditingController();
  String output = "No money is no money, man";

  void _handleTap() {
    setState(() {
      String w = control.text;
      if (w != null && double.tryParse(w) != null) {
        money = double.parse(control.text);
        convertedMoney = money * 4.5;
        output = convertedMoney.toString();
        validInput = true;
      } else {
        validInput = false;
        output = "That's illegal!";
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Image.network(
            "https://images.capital.ro/wp-content/uploads/2019/12/euro-1024x641.jpg"),
        TextField(
          controller: control,
          decoration: InputDecoration(
            labelText: "Enter a value",
            errorText: (validInput == false) ? "Only digits accepted!" : null,
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                _handleTap();
              },
              child: Text(
                "Convert!",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          output,
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}

//------------------------- MyApp ----------------------------------

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("EUR RON Converter!"),
          ),
          body: TapBoxA()),
    );
  }
}
