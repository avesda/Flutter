import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import 'package:app5/models/orders.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold( // provides structure for the page
      body: cart.items.isEmpty // if cart is empty SHOW : "Cart is Empty" in the center of the page 
          ? Center(
              child: Text("Корзина пуста", // 'cart is empty'
                  style: Theme.of(context).textTheme.headline4))
          : Column( // otherwise show a column which has ListView, InputText field, Total sum, complete order button....
              children: [
                Container( // continer which wraps around the ListView 
                  height: 350,
                  child: ListView.builder( // similar to gridView
                    itemCount: cart.itemCount, // number of elements in the list
                    scrollDirection: Axis.horizontal, // scroll direction
                    itemBuilder: (ctx, index) { 
                      return Dismissible( // wraps the dismissible content
                        key: ValueKey(cart.items.values.toList()[index].id), //used by Flutter to distinguish widgets in tree
                        // discussed in the previous sections.
                        direction: DismissDirection.up, // swipe direction 
                        onDismissed: (_) { // anonymous function which is triggered after a completed swipe
                        // removes swiped item from the cart map.
                          cart.removeItem(cart.items.values.toList()[index].id);
                        },
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red[600],
                              border:
                                  Border.all(width: 0.25, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          height: 350,
                          width: 230,
                          padding: EdgeInsets.only(bottom: 15),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 60,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                Text("Я передумал",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.25, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          height: 350,
                          width: 230,
                          margin: EdgeInsets.all(3),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      height: 250,
                                      child: Image.network(cart.items.values
                                          .toList()[index]
                                          .imageUrl)),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 5,
                                    child: Container(
                                      child: Text(
                                          cart.items.values
                                              .toList()[index]
                                              .title,
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15)),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 10,
                                thickness: 1.0,
                                endIndent: 20,
                                indent: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Кол-во: ' +
                                            cart.items.values
                                                .toList()[index]
                                                .quantity
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    Text(
                                      "Размер: M",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    IconButton(
                                      // ADD QUANTITY
                                      icon: Icon(Icons.add_circle),
                                      onPressed: () {
                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .addItem(
                                                cart.items.values
                                                    .toList()[index]
                                                    .id,
                                                cart.items.values
                                                    .toList()[index]
                                                    .price,
                                                cart.items.values
                                                    .toList()[index]
                                                    .title,
                                                cart.items.values
                                                    .toList()[index]
                                                    .imageUrl);
                                      },
                                      splashRadius:
                                          Material.defaultSplashRadius - 10,
                                      constraints: BoxConstraints(
                                          minHeight:
                                              kMinInteractiveDimension - 20,
                                          minWidth:
                                              kMinInteractiveDimension - 20),
                                    ),
                                    SizedBox(width: 2),
                                    IconButton(
                                      icon: Icon(Icons.remove_circle),
                                      onPressed: () {
                                        Provider.of<Cart>(context,
                                                listen: false)
                                            .removeQuantity(
                                                cart.items.values
                                                    .toList()[index]
                                                    .id,
                                                cart.items.values
                                                    .toList()[index]
                                                    .price,
                                                cart.items.values
                                                    .toList()[index]
                                                    .title,
                                                cart.items.values
                                                    .toList()[index]
                                                    .imageUrl);
                                      },
                                      splashRadius:
                                          Material.defaultSplashRadius - 10,
                                      constraints: BoxConstraints(
                                          minHeight:
                                              kMinInteractiveDimension - 20,
                                          minWidth:
                                              kMinInteractiveDimension - 20),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Цена: " +
                                              ((cart.items.values
                                                          .toList()[index]
                                                          .quantity) *
                                                      cart.items.values
                                                          .toList()[index]
                                                          .price)
                                                  .toString() +
                                              ' РУБ',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Промокод",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Итого: " + cart.totalCart().toString() + ' РУБ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: RaisedButton(
                    color: Colors.black,
                    elevation: 3,
                    onPressed: () {
                      Provider.of<Orders>(context,listen:false).addOrder(cart.items.values.toList(), cart.totalCart(),);
                      Navigator.of(context).pushNamed(OrderScreen.routeName);
                      cart.clearCart();
                    },
                    child: Text("Оформить Заказ",
                        style: Theme.of(context).textTheme.headline2),
                  ),
                ),
              ],
            ),
    );
  }
}
