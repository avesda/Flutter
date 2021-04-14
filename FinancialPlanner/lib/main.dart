import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app3/cardsForList.dart';
import 'package:app3/transaction.dart';

import './chart.dart';
import './inputField.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  void startAddingTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            child: InputField(addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void addTransaction(String newName, double newAmount, DateTime selectedDate) {
    final newTX = Transaction(
      id: DateTime.now().toString(),
      name: newName,
      amount: newAmount,
      date: selectedDate,
    );
    setState(() => transactions.add(newTX));
  }

  void deleteTx(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  List<Transaction> get recentTransactions {
    return transactions.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text(
        "Financial Planner ",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[if(isLandscape)
        Switch(
          value: showChart,
          onChanged: (val) {
            setState(() {
              showChart = val;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddingTransaction(context),
          color: Colors.white,
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: <Widget>[if(!isLandscape)
          Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.30,
                  child: Chart(recentTransactions)),
           if(!isLandscape) Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top)*0.70,
                  child: CardsForList(transactions, deleteTx)),
          if (isLandscape)
            showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top)*0.6,
                    child: Chart(recentTransactions))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top),
                    child: CardsForList(transactions, deleteTx)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 50,
        onPressed: () => startAddingTransaction(context),
      ),
    );
  }
}
