import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double totalAmount;

  ChartBar(this.label, this.amount, this.totalAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(children: [
        Container(
            height: constrains.maxHeight*0.15,
            child: FittedBox(
                child: Text('${amount.toStringAsFixed(0)}' + '₺',
                    style: TextStyle(fontSize: 20, color: Colors.white)))),
        SizedBox(height: constrains.maxHeight*0.05),
        Container(
          height: constrains.maxHeight*0.60,
          width: 10,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
                decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10),
            )),
            FractionallySizedBox(
                heightFactor: totalAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ))
          ]),
        ),
        SizedBox(height: constrains.maxHeight*0.05),
        Container(
          height:constrains.maxHeight*0.15,
          child: FittedBox(child: Text(label, style: TextStyle(fontSize: 20, color: Colors.white)))),
      ]);
    });
  }
}
