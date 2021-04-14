import "package:flutter/material.dart";
import './textControl.dart';

class App2 extends StatefulWidget {
  @override
  App2State createState() => App2State();
}

void main() {
  runApp(App2());
}

class App2State extends State<App2> {
  final words = const ["Catch", "Me", "if", "you", "can"];

  var wordCount = 0;
  

  void changeText() {
    setState(() {
      if (wordCount < words.length - 1)
        wordCount++;
      else
        wordCount = 0;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Change text app",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black,
            ),
            body: TextControl(words,changeText,wordCount)));
  }
}
