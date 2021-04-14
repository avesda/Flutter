import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products_list.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-details';

  Widget buildDetails(BuildContext context) {
    String productId = ModalRoute.of(context).settings.arguments as String;
    var product = Provider.of<Products>(context).findById(productId);
    var provider = Provider.of<Product>(context);
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text(product.title,style:Theme.of(context).textTheme.headline2)),
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 450,
              width: double.infinity,
              child: Image.network(product.imageUrl,fit: BoxFit.fitWidth,),
            ),
            Positioned(
                right: 15,
                top: 2,
                child: IconButton(
                  // FAVORITE BUTTON
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 30,
                    color: product.isFavorite ? Colors.red[700] : Colors.black,
                  ),
                  onPressed: () {
                    provider
                        .toggleFavorite(); // separate notifyListeners() for separate classes dont get rtriggered when needed ==> trigger manually!
                    Provider.of<Products>(context, listen: false)
                        .findById(productId)
                        .toggleFavorite();
                  },
                )),
                Positioned(
              // ADD BUTTON
              right: 15,
              top: 35,
              
              child: IconButton(
                icon: Icon(Icons.add, size: 33),
                onPressed: () {cart.addItem(product.id, product.price, product.title,product.imageUrl);}),),
              
            Positioned(
                
                bottom: 5,
                left:0,
                right:0,
                child: Container(
                  
                  alignment: Alignment.center,
                  child: FittedBox(
                                      child: Text(
                      
                      product.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )),
          ]),
          Text(
            product.price.toString()+' РУБ',
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            "Размеры в наличии: S M L XL",
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildDetails(context);
  }
}
