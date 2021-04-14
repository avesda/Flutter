import 'package:app5/models/badge.dart';
import 'package:flutter/material.dart';
import 'products_overview_screen.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'package:provider/provider.dart';
import '../models/products_list.dart';
import '../models/cart.dart';
import '../models/orders.dart';
import './order_screen.dart';
import './admin_settings.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> bodyWidgets;
  void initState() {
    bodyWidgets = [
      {
        'page': AccountScreen(),
        'title': 'Аккаунт', // Account
      },
      {
        'page': ProductsOverviewScreen(),
        'title': 'Волчок', // Name of the shop
      },
      {
        'page': CartScreen(),
        'title': 'Корзина', // Cart
      },
    ];
    super.initState();
  }

  int widgetIndex = 0; // index used to select map in the list

  void selectPage(int index) {
    setState( // runs the build method 
      () { // to rebuild the widget tree and display the changes
        widgetIndex = index; // sets the index, 
      },     // which will be used to select map from the list
    );
  }

  Widget filterButtonProducts() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      onSelected: (selected) => (selected == 0)
          ? Provider.of<Products>(context, listen: false).showAll()
          : Provider.of<Products>(context, listen: false).showFavoritesOnly(),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Все"),
          value: 0,
        ),
        PopupMenuItem(
          child: Text("Избранное"),
          value: 1,
        ),
      ],
    );
  }

  Widget filterButtonCart() {
    return Provider.of<Orders>(context).orders.isEmpty // check if orders page has any orders
        ? Container() // if no -> no button is displayed
        : FlatButton( // else a flatbutton which allows navigation to the orders page
            onPressed: () =>
                Navigator.of(context).pushNamed(OrderScreen.routeName), // navigation // as mentioned before, pushed on stack 
                                                                                    //  allowing user to go back 
            child: Text( // text on the button 
              "Оформить",
              style: Theme.of(context).textTheme.headline2,
            ),
          );
  }

  List<Widget> actionButton(String title) {
    if (title == 'Волчок')   // if page is Product Overviw which has the brand name as the page name
      return [filterButtonProducts()];
    else if (title == 'Корзина') // if Cart
      return [filterButtonCart()];
    else
      return [Container()]; // means display an empty borderless space. Discarded by flutter automatically
  }

  Widget userDrawer() {
    return Container(
      width: 270, // fixed width on any screen 
      child: Drawer( // drawer widget provided by Flutter
        child: Container(
          child: Column( // Column to organize two buttons 
                        //and a logo image on top of each other
            children: [
              AppBar( // 'extending appbar and adding name to the drawer' 
                  automaticallyImplyLeading: false,
                  title: Text(
                    "Меню", //  'MENU' 
                    style: Theme.of(context).textTheme.headline2,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  children: [
                    ListTile( // combination of text and icon (clickable)
                      leading: Icon(
                        Icons.settings,
                        size: 35,
                        color: Colors.black,
                      ),
                      onTap: () => Navigator.of(context) 
                          .popAndPushNamed(AdminSettings.routeName), // pop drawer from the stack 
                          // and push a new screen containing admin rights
                      title: Text(
                        "Админка", // 'admin rights'
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ), // next ListTile for order tracking and logo after this line... 
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.local_shipping,
                        size: 34,
                        color: Colors.black,
                      ),
                      title: Text("Отследить заказ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                    ),
                    Divider(),
                    Container(
                      color: Colors.black,
                      width: 150,
                      height: 160,
                      margin: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Image.asset('./assets/images/logo.png',
                          fit: BoxFit.fill),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return DefaultTabController(
      length: 3, // number of elements on the navigation bar
      initialIndex: 1, // sets the initial page, in our case Produtcs
      child: Scaffold( // wrapps all widgets for rendering
        body: bodyWidgets[widgetIndex]['page'], // retrives the widget 
        // from the list of the maps to render above bottomNavBar and below topBar
        bottomNavigationBar: BottomNavigationBar( // widget which controls the bottom bar
          onTap: selectPage, // function which sets the index 
          currentIndex: widgetIndex, // current page 
          items: [ // list of Icon Buttons to display on the bar
            BottomNavigationBarItem( 
              icon: Icon(
                Icons.account_circle,
              ),
              title: Text('Аккаунт'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_mall,
              ),
              title: Text('Одежда'),
            ),
            BottomNavigationBarItem(
              icon: Badge(
                  child: Icon(
                    Icons.shopping_cart,
                  ),
                  value: cart.itemCount.toString()),
              title: Text('Корзина'),
            ),
          ],
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: userDrawer(),
        appBar: AppBar(
          title: Text( 
            bodyWidgets[widgetIndex]['title'],  // page name
            style: Theme.of(context).textTheme.headline2, // style of the page name text
          ), 
          actions: actionButton(bodyWidgets[widgetIndex]['title']), // Different action button depending on the page
        ),
      ),
    );
  }
}
