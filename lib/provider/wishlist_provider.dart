import 'package:flutter/material.dart';
import 'package:checklist_app/model/wishlist_model.dart';

class WishlistProvider extends ChangeNotifier {
  List<Wishlist> wishlistItems = [];

  void addWishlistItem(String productName, String description, int cost) {
    final newItem = Wishlist(
      '${wishlistItems.length + 1}',
      productName,
      description,
      cost,
    );
    wishlistItems.add(newItem);
    notifyListeners(); // Notify listeners that state has changed
  }

  void updateWishlistItem(String id, String newProductName, String newDescription, int newCost) {
    final index = wishlistItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      wishlistItems[index].productName = newProductName;
      wishlistItems[index].description = newDescription;
      wishlistItems[index].cost = newCost;
      notifyListeners(); // Notify listeners that state has changed
    }
  }

  void deleteWishlistItem(String id) {
    wishlistItems.removeWhere((item) => item.id == id);
    notifyListeners(); // Notify listeners that state has changed
  }
}
