import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products_list.dart';
import './product_edit_screen.dart';
import '../models/product.dart';

class AdminSettings extends StatefulWidget {
  static const routeName = '/admin-settings';
  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {

bool _isInit = true;
bool _isLoading = false;

void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  void deleteSelected() {
    var provider = Provider.of<Products>(context, listen: false);
    for (int i = 0; i < provider.loadedProducts.length; i++) {
      if (provider.loadedProducts[i].isSelected)
        provider.deleteProduct(provider.loadedProducts[i].id);
    }
  }

  Future<void> refreshProducts()
  {
    return Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<Products>(context);
    var product = Provider.of<Product>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Rights",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
        onRefresh: refreshProducts,
              child: Container(
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Товары",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete,
                              size: 30, color: Colors.red[600]),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Удалить товар?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 46),
                                      width: 250,
                                      child: Row(
                                        children: [
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.of(ctx)
                                                  .pop(deleteSelected());
                                            },
                                            child: Text("Да"),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("Нет"),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 30, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                ProductEditScreen.routeName,
                                arguments: 'new');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: products.loadedProducts.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                products.loadedProducts[index].imageUrl,
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          products.loadedProducts[index].title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: FittedBox(
                          child: Row(
                            children: [
                              IconButton(
                                constraints:
                                    BoxConstraints(maxHeight: 40, maxWidth: 40),
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    ProductEditScreen.routeName,
                                    arguments: products.loadedProducts[index].id,
                                  );
                                },
                              ),
                              IconButton(
                                constraints:
                                    BoxConstraints(maxHeight: 40, maxWidth: 40),
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.check_box,
                                  color: products.loadedProducts[index].isSelected
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    Provider.of<Product>(context, listen: false)
                                        .toggleSelected();
                                    products.loadedProducts[index]
                                        .toggleSelected();
                                  });
                                },
                              ),
                              IconButton(
                                constraints:
                                    BoxConstraints(maxHeight: 40, maxWidth: 40),
                                splashRadius: 20,
                                icon: Icon(
                                  products.loadedProducts[index].isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    product.toggleVisible();
                                    Provider.of<Products>(context, listen: false)
                                        .findById(
                                            products.loadedProducts[index].id)
                                        .toggleVisible();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10, right: 5),
                      );
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
