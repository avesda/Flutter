import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/todo_element.dart';


class InputScreen extends StatefulWidget {
  static const routeName = '/input-screen';

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  DateTime selectedDate;

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2021),)
        .then((pickedDate) {
      if (pickedDate == null) 
        return;
        setState(() {
          selectedDate = pickedDate;
          
        });
    });
  }

  List<Color> colorList = [
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.deepOrange,
    Colors.black,
    Colors.green,
    Colors.indigo,
    Colors.purple,
  ];

  var selectedColor;

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();

  void submitData(context) {
    final title = nameController.text;
    final description = descriptionController.text;
    if (title.isEmpty || selectedDate==null) return;
    Navigator.of(context).pop(ToDoElement(
        id: DateTime.now().toString(),
        title: title,
        description: description,color: selectedColor,date :selectedDate)); // closes the sheet after submitting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Add New Item", style: Theme.of(context).textTheme.headline6),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          height: 500,
          child: Column(
            children: [
              Text(
                "Adding new item:",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: nameController,
                onSubmitted: (_) => submitData(context),
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                onSubmitted: (_) => submitData(context),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'),
              ),
               Container(
                    margin: EdgeInsets.only(top: 10,bottom: 25),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedDate == null ?
                          "No date selected" : 'Picked Date: ' + DateFormat.yMMMd().format(selectedDate),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              child: Text(
                                "Choose a date",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              color: Theme.of(context).accentColor,
                              onPressed: presentDatePicker,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ))
                      ],
                    )),
              Container(
                height: 150,
                child: GridView.builder(
                  itemCount: colorList.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 160,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 3/1),
                  itemBuilder: (ctx, index) {
                    return IconButton(
                        icon: Icon(Icons.bubble_chart,color: colorList[index], ), onPressed: () {selectedColor = colorList[index];});
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 10, top: 10),
                child: Container(
                  height: 40,
                  width: 90,
                  child: RaisedButton(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Theme.of(context).accentColor,
                    onPressed: () => submitData(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
