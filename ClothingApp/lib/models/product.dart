import 'package:flutter/foundation.dart';
import 'products_list.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final int price; // 
  final String imageUrl;
  bool isSelected; // to be used in admin mode for deleting
  bool isVisible; // to hide product from the Products Screen
  bool isFavorite; // adding product to the fav list

  void toggleFavorite()
  {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void toggleVisible()
  {
    isVisible = !isVisible;
    notifyListeners();
  }

  void toggleSelected()
  {
    isSelected = !isSelected;
    notifyListeners();
  }

  Product(
      {
      this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavorite = false,
      this.isSelected = false,
      this.isVisible = true});
}
