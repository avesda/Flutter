import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);
    var cart = Provider.of<Cart>(context, listen: false);
    return Card(
      child: GestureDetector( // listener for user tapping on the area inside the card
        child: Stack(children: [ // stack of elements
          Container( // imaginary container with boundaries to contain the image
            child: Image.network( // fetching image from the website 
              product.imageUrl,
              fit: BoxFit.contain, 
            ),
          ),
          Consumer<Product>( // provider of the product class
            builder: (context, product, _) => Positioned( // positioning of the fav button 
                right: 2,
                bottom: 2,
                child: IconButton(
                  // FAVORITE BUTTON
                  icon: Icon( // icon properties
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 24,
                    color: product.isFavorite ? Colors.red[700] : Colors.black,
                  ),
                  onPressed: () {
                    product.toggleFavorite(); // changes isFavorite 1/0 or 0/1
                  },
                )),
          ),
          Positioned(
              // ADD BUTTON
              right: 2,
              top: 2,
              child: IconButton(
                icon: Icon(Icons.add, size: 27),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title,
                      product.imageUrl);
                      Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                      
                      action: SnackBarAction(label: "Отменить", onPressed: ()=> cart.removeSingleItem(product.id),textColor: Colors.yellow,),
                      duration: Duration(seconds: 2),
                      content: Text("Добавлено в корзину")));
                },
              )),
          Positioned(
            bottom: 10,
            left: 15,
            child: FittedBox(
              child: Text(
                product.price.toString() + ' РУБ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ]),onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetails.routeName, arguments: product.id);
        },
      ),
    );
  }
}
