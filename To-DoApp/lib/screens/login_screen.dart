import 'package:flutter/material.dart';
import './tabs_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
          child: FittedBox(
                      child: Column(
        children: <Widget>[
            Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            GestureDetector(
              
              child: Text("Log in",style: Theme.of(context).textTheme.headline6,),
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(TabsScreen.routeName),
            ),
        ],
      ),
          )),
    );
  }
}
