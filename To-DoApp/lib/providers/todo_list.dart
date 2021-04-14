import 'package:flutter/material.dart';
import '../models/todo_element.dart';

class TodoList with ChangeNotifier {

  List<ToDoElement> todoList = [ToDoElement(id: '12', title: 'lol',color: Colors.red,date: DateTime.now()),ToDoElement(id: '13', title: 'bot',date: DateTime.now())];

  var filter;
  bool dateFilterDir = true;
  Color filterColor;

  void toggleDateDir()
  {
    dateFilterDir = !dateFilterDir;
  } 

  void setFilterColor(Color color)
  {
    filterColor = color;
    notifyListeners();
  }

  Color get getFilterColor
  {
    return filterColor;
  }
  // set setDateFilterDir(bool value)
  // {
  //   dateFilterDir = value;
  //   notifyListeners();
  // }

  bool get getDateFilterDir
  {
    return dateFilterDir;
  }

  void filterValueSet(int value)
  {
    if(filter == value && value == 1)
      toggleDateDir();
    filter = value;
    notifyListeners();
  }
  int get filterValueGet
  {
    return filter;
  }

  List<ToDoElement> get getTodoList
  {
    return [...todoList];
  }
  void addTodoElement(ToDoElement element)
  {
    todoList.add(element);
    print(element.title+' added');
    notifyListeners();
  }
  void doneToggle(String id)
  {
    var index = todoList.indexWhere((element) => element.id == id);
    if(todoList[index].done)
      todoList[index].done = false;
    else
      todoList[index].done = true;
    notifyListeners();
  }

}