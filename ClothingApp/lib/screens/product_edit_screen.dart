import 'package:flutter/material.dart';
import '../models/products_list.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductEditScreen extends StatefulWidget {
  static const routeName = '/product-edit-screen';

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  FocusNode descriptionNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode imageUrlNode = FocusNode();
  TextEditingController imageInputController = TextEditingController();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  String title = '';
  String description = '';
  int price = 0;
  String imageUrl = '';

  @override
  void initState() {
    imageUrlNode.addListener(updateImage);
    super.initState();
  }

  @override
  void dispose() {
    imageUrlNode.removeListener(updateImage);
    imageUrlNode.dispose();
    descriptionNode.dispose();
    priceNode.dispose();
    imageInputController.dispose();
    super.dispose();
  }

  void updateImage() {
    if (!imageUrlNode.hasFocus) setState(() {});
  }

  void saveForm(BuildContext context, String productID) {
    if (!form.currentState.validate()) return;
    form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    
    var provider = Provider.of<Products>(context, listen: false);
    if (productID == 'new') {
      provider.addProduct(Product(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          description: description,
          imageUrl: imageUrl)
          
          
          
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
      
    } else
    {
       provider.updateProduct(
          productID,
          Product(
              id: productID,
              title: title,
              price: price,
              description: description,
              imageUrl: imageUrl));
      setState(() {
        _isLoading = false;
      });Navigator.of(context).pop();
    }
     
  }

  bool initBool = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (initBool) {
      var productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != 'new') {
        imageInputController.text =
            Provider.of<Products>(context, listen: false)
                .findById(productID)
                .imageUrl;
      }
      initBool = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var productID = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => saveForm(context, productID))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: form,
              child: Container(
                padding: EdgeInsets.all(16),
                height: 650,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Имя товара'),
                        initialValue: productID == 'new'
                            ? ''
                            : Provider.of<Products>(context, listen: false)
                                .findById(productID)
                                .title,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(priceNode),
                        onSaved: (value) => title = value,
                        validator: (value) {
                          if (value.isEmpty) return 'Введите имя товара';
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Цена'),
                        initialValue: productID == 'new'
                            ? ''
                            : Provider.of<Products>(context, listen: false)
                                .findById(productID)
                                .price
                                .toString(),
                        focusNode: priceNode,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(descriptionNode),
                        onSaved: (value) => price = int.parse(value),
                        validator: (value) {
                          if (value.isEmpty) return 'Введите цену товара';
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Описание'),
                        initialValue: productID == 'new'
                            ? ''
                            : Provider.of<Products>(context, listen: false)
                                .findById(productID)
                                .description,
                        keyboardType: TextInputType.multiline,
                        focusNode: descriptionNode,
                        maxLines: 3,
                        onSaved: (value) => description = value,
                        validator: (value) {
                          if (value.isEmpty) return 'Введите описание товара';
                          return null;
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 350,
                        child: Column(
                          children: [
                            Container(
                              height: 230,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: productID == 'new'
                                  ? (imageInputController.text.isEmpty
                                      ? Image.asset(
                                          './assets/images/no_image.png')
                                      : Image.network(
                                          imageInputController.text,
                                          fit: BoxFit.fitWidth,
                                        ))
                                  : Image.network(
                                      Provider.of<Products>(context,
                                              listen: false)
                                          .findById(productID)
                                          .imageUrl,
                                    ),
                            ),
                            Container(
                              height: 120,
                              child: TextFormField(
                                maxLines: 5,
                                controller: imageInputController,
                                decoration: InputDecoration(
                                  labelText: 'Ссылка на фото товара',
                                ),
                                focusNode: imageUrlNode,
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () => setState(() {}),
                                onFieldSubmitted: (_) =>
                                    saveForm(context, productID),
                                onSaved: (value) => imageUrl = value,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Введите ссылку на фото товара';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
