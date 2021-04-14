import 'package:flutter/material.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  );

  bool expanded = false;

  bool expandedGet(){
    return expanded;
  }
  void expandedToggle(){
    expanded = !expanded;
  }

}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }
  

  int globalID = 1;
  void addOrder(List<CartItem> cartProducts, int totalAmount) {
    _orders.insert(
      0,
      OrderItem(
        'o' + (globalID++).toString(),
        totalAmount,
        cartProducts,
        DateTime.now(),
      ),
    );
    notifyListeners();
  }
  void deleteOrder(int index)
  {
    _orders.removeAt(index);
    notifyListeners();
  }

}
