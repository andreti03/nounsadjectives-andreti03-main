import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  final _random = new Random();
  int _counter = 0;


  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  Future<void> wrong(BuildContext context){
    return showDialog<void>(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Lo siento!'),
          content: const Text('Te equivocaste!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Intentar de nuevo'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }
    setState(() {
      _theState = randomItem;
      _actualWordType = option;
    });
  }

  void _onPressed(int option) {
    if (option == _actualWordType) {
      print("good");
      _counter++;
    }else {
      print("not good");
      wrong(context);
    }
    setRandomWord();
  }

  void _onReset(int op) {
    if (op==1){
      _counter=0;
    }
    setRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8B8B8),
      appBar: AppBar(
        title: Text("Random Words"),
        foregroundColor: Colors.black,
        backgroundColor: Color(0xFFFFD700),
        backwardsCompatibility: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Text("Score: $_counter  ",
            textScaleFactor: 2.0,
            style: TextStyle(color: Colors.blue)),
            ),
          Text("$_theState",
            textScaleFactor: 2.0,
            style: TextStyle(color: Colors.blue)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => _onPressed(0), 
                  child: Text("Noun"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.yellow
                  )),
              ElevatedButton(
                  onPressed: () => _onPressed(1), 
                  child: Text("Adjective"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    onPrimary: Colors.yellow
                  )),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              onPressed: () => _onReset(1), 
              icon: Icon(Icons.refresh), 
              label: Text(''),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFB8B8B8),
                onPrimary: Colors.black,
                elevation: 0
            ))
          ),
        ],
      ),
    );
  }
}
