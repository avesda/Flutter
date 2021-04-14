import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  final Function addTx;
  InputField(this.addTx);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final nameInput = nameController.text;
    final amountInput = double.parse(amountController.text);

    if (nameInput.isEmpty || amountInput <= 0.0 || selectedDate == null) 
      return;

    widget.addTx(
      nameInput,
      amountInput,
      selectedDate,
    );

    Navigator.of(context).pop(); // closes the sheet after submitting
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) 
        return;
        setState(() {
          selectedDate = pickedDate;
          
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
          elevation: 50,
          child: Container(
            padding: EdgeInsets.only(left: 5,bottom: MediaQuery.of(context).viewInsets.bottom + 10,),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  controller:
                      nameController, //onChanged: (value) => nameInput = value,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller:
                      amountController, //onChanged: (value) => amountInput = value,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 30,
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
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Theme.of(context).accentColor,
                      onPressed: submitData,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ))
              ],
            ),
          )),
    );
  }
}
