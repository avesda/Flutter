import 'package:app5/models/orders.dart';
import 'package:app5/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';

import './customColor/custom_color.dart';
import './screens/main_menu.dart';
import './screens/product_detail.dart';
import 'package:provider/provider.dart';
import './models/products_list.dart';
import './models/product.dart';
import './models/cart.dart';
import './screens/tabs_screen.dart';
import './screens/order_screen.dart';
import './screens/approve_screen.dart';
import './screens/admin_settings.dart';
import './screens/product_edit_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx)=> Products()),
          ChangeNotifierProvider(create: (ctx)=> Product()),
          ChangeNotifierProvider(create: (ctx)=> Cart()),
          ChangeNotifierProvider(create: (ctx)=> Orders()),
        ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData(
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
            headline4: TextStyle(
              color: Colors.grey,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            headline1: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          primarySwatch: primaryBlack,
        ),
        initialRoute: '/',
        routes: 
        {
          '/': (ctx) =>  MainMenu(),
          ProductsOverviewScreen.routeName : (ctx) => ProductsOverviewScreen(),
          ProductDetails.routeName : (ctx) => ProductDetails(),
          TabsScreen.routeName : (ctx) => TabsScreen(),
          OrderScreen.routeName : (ctx) => OrderScreen(),
          ApproveScreen.routeName : (ctx) => ApproveScreen(),
          AdminSettings.routeName : (ctx) => AdminSettings(),
          ProductEditScreen.routeName : (ctx) => ProductEditScreen(), 
        },
      ),
    );
  }
}

