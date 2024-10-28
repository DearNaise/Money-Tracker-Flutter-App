import 'package:flutter/material.dart';
import 'package:checklist_app/model/wishlist_model.dart';
import 'package:checklist_app/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

// Method to add a new item to the wishlist
void addItem(BuildContext context, TextEditingController productNameController, TextEditingController descriptionController, TextEditingController costController) {
  // Clear the text controllers before adding a new item
  productNameController.clear();
  descriptionController.clear();
  costController.clear();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [

              // Title
              const Text(
                'Add Item to Wishlist',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Product name
              const SizedBox(height: 20),
              TextField(
                controller: productNameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                ),
              ),

              // Description
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                ),
                maxLines: 3,
              ),

              // Cost
              const SizedBox(height: 20),
              TextField(
                controller: costController,
                decoration: InputDecoration(
                  labelText: 'Cost',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                ),
                keyboardType: TextInputType.number,
              ),

              // Add button
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                  onPressed: () {
                    // Add a new wishlist item
                    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
                    wishlistProvider.addWishlistItem(
                      productNameController.text,
                      descriptionController.text,
                      int.tryParse(costController.text) ?? 0,
                    );
                    // Close the bottom sheet
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60,// Set the text color of the button
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // Add padding
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Method to edit an existing item in the wishlist
void editItem(BuildContext context, Wishlist item, TextEditingController productNameController, TextEditingController descriptionController, TextEditingController costController) {
  // Pre-fill the text controllers with the item's values
  productNameController.text = item.productName;
  descriptionController.text = item.description;
  costController.text = item.cost.toString();

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Item',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: productNameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: costController,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Update the wishlist item
                  final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
                  wishlistProvider.updateWishlistItem(
                    item.id,
                    productNameController.text,
                    descriptionController.text,
                    int.tryParse(costController.text) ?? 0,
                  );
                  // Close the bottom sheet
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Method to delete an existing item from the wishlist
void deleteItem(BuildContext context, Wishlist item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Delete the wishlist item
              final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
              wishlistProvider.deleteWishlistItem(item.id);
              // Close the dialog
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

// Method to show the detail view in a dialog box
void showDetailView(BuildContext context, Wishlist item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(item.productName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(item.description),
            SizedBox(height: 10),
            Text(
              'Cost:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${item.cost}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
