import 'dart:async';

import './tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  @override
  void initState() { // first function to execute on the screen 
    Timer(Duration(seconds:2), // wait 2 seconds
    () => Navigator.pushReplacementNamed(context,TabsScreen.routeName,),);
    // navigate to Tabs Screen which contains Products Overview Screen
    super.initState(); 
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 370,
        width: 250,
        child: Column(children: [Container(
            height: 300,
            width: 250,
            child: Image.asset('./assets/images/logo.png', fit: BoxFit.cover),
          ),
          SizedBox(height:15),
          SpinKitHourGlass(color: Colors.white),
          
          ],
                
        ),
      ),
    );
  }
}
