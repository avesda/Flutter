import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app3/transaction.dart';

class CardsForList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  CardsForList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Transactions",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 150,
                        child: Image.asset('./assets/images/waiting.png'),
                      ),
                    ],
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 8, right: 8),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '${transactions[index].amount.toStringAsFixed(0)}' +
                                  '₺',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      trailing: Wrap(spacing: -13,children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: null,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                      ]),
                    ),
                  );
                },
              ));
  }
}
