import "package:flutter/material.dart";
import 'dart:math';
import './text.dart';

class TextControl extends StatelessWidget {
  final words;
  final wordCount;
  final Function changeText;
  TextControl(this.words, this.changeText, this.wordCount);

  final Random random = new Random();
  double setRotation() {
    return random.nextDouble() / 5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.lightGreen,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            border: Border.all(color: Colors.yellow[200], width: 3)),
        width: 200,
        height: 200,
        transform: Matrix4.rotationZ(setRotation()),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextItself(words,wordCount),
            RaisedButton(
              onPressed: changeText,
              child: Text(
                "X",
                style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              color: Colors.black,
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
