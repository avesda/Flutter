import 'package:flutter/material.dart';
import 'package:to_do_list_app/screens/input_screen.dart';
import 'package:to_do_list_app/screens/login_screen.dart';
import 'package:to_do_list_app/screens/tabs_screen.dart';

import './colors/custom_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(headline6: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color:Colors.white)),
        primarySwatch: primaryBlack,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:LoginScreen(),
      routes: {
        InputScreen.routeName : (ctx) => InputScreen(),
        TabsScreen.routeName : (ctx) => TabsScreen(),
      },
    );
  }
}

