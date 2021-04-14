import 'package:flutter/foundation.dart';

class CartItem {
  String id; // cart ID has the same ID as the product
  String title;
  int quantity; // number of pieces of the same product
  int price; // total price
  String imageUrl; 

  CartItem(  // constructor
      {@required this.id, // @required throws error if argument following it is empty
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.imageUrl});
}

class Cart with ChangeNotifier {
  int globalId = 5;

  Map<String, CartItem> _items = {}; // all cart items are stored in map where key is a new Cart ID
  Map<String, CartItem> get items { // getter a reference of the map
    return _items;
  }
  int get itemCount { // get function for length of the map
    return _items.length;
  }
  void addItem(String productID, int price, String title, String imageUrl) { // recieves the details of the product
    if (!_items.containsKey(productID)) {
      _items.putIfAbsent( // if product id has no occurences in the map -> add to the map
          productID,
          () => CartItem(  // create a cart item based on the product
              id: productID,
              price: price,
              title: title,
              quantity: 1, // set quantity to 1
              imageUrl: imageUrl));
      notifyListeners(); // listener of the provider package, 
    } else             // e.g if new product added to the cart, rebuilds will happen to display the changes.
      addQuantity(productID, price, title, imageUrl); // if an instance of the product already exists -> increase the quantity
  }
  void addQuantity(String productID, int price, String title, String imageUrl) {
    if (_items.containsKey(productID)) {
      _items.update(  // updates the existing cart item. 
          productID,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1, // increment by 1
              title: value.title,
              imageUrl: value.imageUrl));
      notifyListeners();
    }
  }

void removeSingleItem(String productID)
  {
    if(_items.containsKey(productID))
    {
      if(_items[productID].quantity>1)
      {
        _items.update(productID, (value) => CartItem(id: value.id, title:value.title, quantity: value.quantity-1, price: value.price, imageUrl: value.imageUrl),);
      }
      else
        _items.remove(productID);
    }
    else
      return;
    notifyListeners();
  }
  void removeQuantity(
      String productID, int price, String title, String imageUrl) {
    if (_items.containsKey(productID)) {
      if (_items[productID].quantity > 1) {
        _items.update(
            productID,
            (value) => CartItem(
                id: value.id,
                price: value.price,
                quantity: value.quantity - 1,
                title: value.title,
                imageUrl: value.imageUrl));

        notifyListeners();
      }
    }
  }
  int totalCart()
  {
    int total = 0;
    _items.forEach((key, value) {
      total+=value.price*value.quantity;
    });
    return total;
  }

  void removeItem(String productID)
  {
    _items.remove(productID);
    notifyListeners();
  }

  void clearCart()
  {
    _items = {};
    notifyListeners();
  }
}
