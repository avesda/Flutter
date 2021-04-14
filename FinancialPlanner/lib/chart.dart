import 'package:app3/chart_bar.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double daySum = 0.0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year)
            daySum += recentTransactions[i].amount;
        }
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': daySum
        };
      },
    ).reversed.toList();
  }

  double get totalAmount {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).accentColor,
        ),
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((element) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                element['day'],
                element['amount'],
                totalAmount == 0
                    ? 0.0
                    : (element['amount'] as double) / totalAmount),
          );
        }).toList(),
      ),
    ));
  }
}
