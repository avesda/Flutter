import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ToDoElement{
  final String id;
  final String title;
  String description;
  Color color;
  bool done;
  DateTime date;

  ToDoElement({
    @required this.id,
    @required this.title,
    this.description = 'No description',
    this.color= Colors.yellow,
    this.done = false,
    @required this.date,
  });


}