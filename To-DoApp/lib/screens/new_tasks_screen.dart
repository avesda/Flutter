import 'package:flutter/material.dart';
import 'package:to_do_list_app/providers/todo_list.dart';
import '../models/todo_element.dart';
import '../screens/input_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewTasksScreen extends StatelessWidget {
  Widget buildListView(BuildContext context) {
    List<ToDoElement> todoList = Provider.of<TodoList>(context).todoList;
    List<ToDoElement> sortedList = [...todoList];
    sortedList.removeWhere(
      (element) => element.done,
    );
    if(Provider.of<TodoList>(context,listen: false).filterValueGet == 1)
    {
      if(Provider.of<TodoList>(context,listen: false).getDateFilterDir == true)
      {
        sortedList.sort((a,b)=> a.date.compareTo(b.date));
      }
      else
      {
        sortedList.sort((a,b)=> a.date.compareTo(b.date));
        sortedList = sortedList.reversed.toList();
      }
    }
    else if(Provider.of<TodoList>(context,listen: false).filterValueGet == 2)
    {
      sortedList.removeWhere((element) => element.color != Provider.of<TodoList>(context,listen: false).getFilterColor);
    }
    return sortedList.isEmpty
        ? Center(
            child: Text("Nothing here"),
          )
        : ListView.builder(
            itemCount: sortedList.length,
            itemBuilder: (ctx, index) => Card(
              child: ListTile(
                leading: IconButton(icon: Icon(
                        sortedList[index].done
                      ? Icons.check_circle
                      : Icons.check_circle_outline,),
                      color: sortedList[index].done ? Colors.yellow : Colors.black,
                      highlightColor: Colors.yellow,
                      iconSize: 30,
                      onPressed: () => Provider.of<TodoList>(context,listen:false).doneToggle(sortedList[index].id),
                ),
                title: Text(
                  sortedList[index].title + ' • ' + DateFormat.yMMMd().format(sortedList[index].date),
                ),
                subtitle: Text(
                  sortedList[index].description,
                ),
                trailing: Icon(
                  Icons.bubble_chart,
                  size: 40,
                  color: sortedList[index].color,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(InputScreen.routeName).then((value) => Provider.of<TodoList>(context,listen: false).addTodoElement(value)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
