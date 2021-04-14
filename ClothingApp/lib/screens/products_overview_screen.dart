import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_list.dart';
import '../models/product_item.dart';
import '../models/product.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview-screen';

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  Widget buildGrid(BuildContext context) {
    var loadedProducts = Provider.of<Products>(context).list;
    //var product = Provider.of<Product>(context); // not used
    return GridView.builder(
      itemCount: loadedProducts.length, // number of items to display 
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent( 
        maxCrossAxisExtent: 200, // maximum width of a single grid element (card)
        mainAxisSpacing: 15, // vertical space between grid elements
        crossAxisSpacing: 15, // horizontal spacing between elements
        childAspectRatio: 2 / 3, // 2 cards horizontally to 3 cards vertically 
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value( // for each product in the list 
          value: loadedProducts[index], child: ProductItem()), // create a Card item
    ); // and list them in a grid
  }

bool _isInit = true; 
bool _isLoading = false; // to set the refreshing indicator

void didChangeDependencies() { // this function is internal to Flutter and is called periodically
                              // to check for the updates in the contents of the application
    if (_isInit) { // show loading indicator while the data is being fetched 
      setState(() { 
        _isLoading = true; 
      });
      
      Provider.of<Products>(context).fetchAndSetProducts().then((_) { // fetch and after completion 
                                                               // turn off the loading indicator
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false; 
    super.didChangeDependencies();
  }
  
  Future<void> refreshProducts()
  {
    return Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body:_isLoading // if loading show a loading indicator 
          ? Center(
              child: CircularProgressIndicator(), // loading indicator widget
            )
          : RefreshIndicator(  // else display fetched data, 
          //which is also wrapped into a Refresh indicator widget allowing pulling the page down to refresh
            onRefresh: refreshProducts, // fetches data again if screen is pulled down 
                      child: Container(
                height: MediaQuery.of(context).size.height,
                child: buildGrid(context)), // builds the grid of fetched products
          ),
    );
  }
}
