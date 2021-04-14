import 'package:flutter/material.dart';

class ApproveScreen extends StatefulWidget {
  static const routeName = '/approve-screen';

  @override
  _ApproveScreenState createState() => _ApproveScreenState();
}

class _ApproveScreenState extends State<ApproveScreen> {
  int agree=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FittedBox(
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Ваш заказ принят",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
