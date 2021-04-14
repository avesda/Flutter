import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
   List<Product> loadedProducts = [];


  void resetProducts()
  {
    loadedProducts = [];
  }

  bool _showFavoritesOnly = false;

  List<Product> get list {
    if (_showFavoritesOnly) {
      return loadedProducts
          .where((prodItem) => prodItem.isFavorite && prodItem.isVisible)
          .toList();
    } else
      return [
        ...loadedProducts.where((prodItem) => prodItem.isVisible).toList()
      ];
  }

  Product findById(String id) {
    return loadedProducts.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async { // async function allows me to use await key, to force Flutter wait for a responce 
    resetProducts(); // sets loadedProducts to [] to achive refreshing effect.
    const url = 'https://volchok-v1.firebaseio.com/products.json'; // link to reach the products in the database
      final response = await http.get(url); // wait until data is successfully fetched from Firebase
      final extractedData = json.decode(response.body) as Map<String, dynamic>; // decode the message into a Map of String and a dynamic
      extractedData.forEach((prodId, prodData) { // for each id key in the extracted map use dynamic prodData to access product details
        loadedProducts.add(Product( // add a new product item to the local array of products 
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
     notifyListeners(); // force rebuilds to display changes
  }


  Future<void> addProduct(Product product) {
    const url = 'https://volchok-v1.firebaseio.com/products.json'; // link to the products directory
    return http // posting the product details 
        .post(
      url,
      body: json.encode( // encoding data into json format
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
          'isVisible': product.isVisible,
          'isSelected': product.isSelected,
        },
      ),
    )
        .then((response) { // after getting a responce, adds the new product to the local array for futher use.
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'], // decoding the id that was created by Firebase 
      );
      loadedProducts.insert(0,newProduct); // adding the product to the array 
      notifyListeners(); // forces rebuilds and product appears on the pages.
    });
  }

   Future<void> updateProduct(String id, Product newProduct)  { 
    final prodIndex = loadedProducts.indexWhere((prod) => prod.id == id); // find product index using id that has to be updated
    final url = 'https://volchok-v1.firebaseio.com/products/$id.json'; // link to that product, using String interpolation
    loadedProducts[prodIndex] = newProduct; // update the pruduct locally
    notifyListeners(); // force update screns
    return http.patch(url, // update product in the database
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price
        }));
  }

  Future<void> deleteProduct(String id) {
    final url = 'https://volchok-v1.firebaseio.com/products/$id.json'; 
    final existingProductIndex = loadedProducts.indexWhere((prod) => prod.id == id);//index of the product to be deleted
    loadedProducts.removeAt(existingProductIndex); // delete product from local storage
    notifyListeners(); // force update screns
    return http.delete(url); // delete product from the database
    
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }
/*
  void deleteProduct(String productID) {
    loadedProducts.removeWhere((element) => element.id == productID);
    notifyListeners();
  }*/
/*
  Future<void> updateProduct(String id, Product product) {
    
    notifyListeners();
  }*/
}
