import "package:flutter/material.dart";

class TextItself extends StatelessWidget {
  final wordCount;
  final words;
  TextItself(this.words,this.wordCount);
  @override
  Widget build(BuildContext context) {
    return Text(
              words[wordCount],
              style: TextStyle(fontSize: 36),
            );
  }
}