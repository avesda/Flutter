import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/orders.dart';
import './approve_screen.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


  void dismissDir(DismissDirection direction, BuildContext context, int index) {
    Provider.of<Orders>(context, listen: false).deleteOrder(index); // approved or deleted, the order will be removed from he page
    if (direction == DismissDirection.startToEnd) { // if approved an 'approved' page is pushed on stack
      Navigator.of(context).pushNamed(ApproveScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Заказы", style: Theme.of(context).textTheme.headline2),
      ),
      body: orders.orders.isEmpty
          ? Center(
              child: Text(
                "Пусто",
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Dismissible(
                  onDismissed: (direction) {
                    dismissDir(direction, context, index); // dismissDir decides what action to perfom based on direction of the swipe.
                  },
                  confirmDismiss: (direction) { if(direction==DismissDirection.startToEnd) return Future.value(true); else return showDialog(
                   // uses future value to confirm the action. 
                    context: context,
                    builder: (ctx) => AlertDialog( // push an alert dialog on screen 
                      title: Text(
                        "Удалить заказ?", // text "are you sure you want to delete?"
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      actions: [ // buttons to which return either Future true or false 
                      // alert dialog pops from the stack after pressing any of the buttons
                       // or anywhere outside the alert dialog 
                        Container(padding: EdgeInsets.symmetric(horizontal: 46),width:250,child:Row(children: [ RaisedButton(
                          onPressed: () {
                            
                            Navigator.of(ctx).pop(true); // returns Future true 
                          },
                          child: Text("Да"), // "yes"
                        ),
                        SizedBox(width: 30,),
                        RaisedButton(
                          onPressed: () {
                            
                            Navigator.of(ctx).pop(false); // returns Future false
                          },
                          child: Text("Нет"), // "No"
                        ),],)),
                       
                        
                      ],
                    ),
                  );},
                  key: ValueKey(orders.orders[index].id),
                  
                  secondaryBackground: Container(
                      height: 160,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.red[100],
                            Colors.red[900],
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      )),
                  background: Container(
                      height: 160,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Colors.green[100],
                            Colors.green[900],
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.offline_pin,
                        color: Colors.white,
                        size: 30,
                      )),
                  child: Column(children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Column(children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    child: Image.network(
                                      orders.orders[index].products[0].imageUrl,
                                    ),
                                  ),
                                  orders.orders[index].products.length > 1
                                      ? Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.black26,
                                            ),
                                            alignment: Alignment.center,
                                            height: 130,
                                            width: 130,
                                            child: Text(
                                                "+" +
                                                    (orders
                                                                .orders[index]
                                                                .products
                                                                .length -
                                                            1)
                                                        .toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: FittedBox(
                                  child: Text(
                                    "Номер заказа: " + orders.orders[index].id,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  height: 130,
                                  width: 210,
                                  //color: Colors.red,
                                  child: ListView.builder(
                                    itemBuilder: (ctxx, prodIndex) {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        alignment: Alignment.centerLeft,
                                        height: 40,
                                        width: 190,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    orders
                                                        .orders[index]
                                                        .products[prodIndex]
                                                        .imageUrl,
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              height: 40,
                                              width: 40,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: Text(orders.orders[index]
                                                      .products[prodIndex].price
                                                      .toString() +
                                                  ' Р'),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text('  X '),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text(orders.orders[index]
                                                  .products[prodIndex].quantity
                                                  .toString()),
                                            ),
                                            VerticalDivider(
                                              thickness: 1,
                                            ),
                                            Spacer(),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: Text((orders
                                                              .orders[index]
                                                              .products[
                                                                  prodIndex]
                                                              .quantity *
                                                          orders
                                                              .orders[index]
                                                              .products[
                                                                  prodIndex]
                                                              .price)
                                                      .toString() +
                                                  ' Р'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount:
                                        orders.orders[index].products.length,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height: 30,
                                  width: 210,
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: orders.orders[index].expandedGet()
                                            ? Icon(
                                                Icons.expand_less,
                                              )
                                            : Icon(Icons.expand_more),
                                        splashColor: Colors.transparent,
                                        onPressed: () {
                                          setState(() {
                                            orders.orders[index]
                                                .expandedToggle();
                                          });
                                        },
                                      ),
                                      Spacer(),
                                      Text(
                                        "Итог: ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        orders.orders[index].amount.toString() +
                                            ' Р',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (orders.orders[index].expandedGet())
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          DateTime.now().toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Colors.black26,
                        ),
                      ),
                  ]),
                );
              },
              itemCount: orders.orders.length,
            ),
    );
  }
}
