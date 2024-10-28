import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checklist_app/provider/wishlist_provider.dart';
import 'package:checklist_app/widget_style/widget_color.dart';
import 'package:checklist_app/controller/wishlist_control.dart';

class WishlistPage extends StatefulWidget {
  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context); // Access the provider
    final myColor = WidgetColor();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const Text('Make a Wish'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myColor.buttonColor,
        onPressed: () {
          addItem(context, _productNameController, _descriptionController, _costController); // Use addItem method from methods file
        },
        child: Image.asset('assets/icons/pen.png', width: 22),
      ),
      body: ListView.builder(
        itemCount: wishlistProvider.wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistProvider.wishlistItems[index];
          return ListTile(
            title: Text(item.productName),
            subtitle: Text('${item.description} \n Cost: ${item.cost} K'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    editItem(context, item, _productNameController, _descriptionController, _costController); // Use editItem method from methods file
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteItem(context, item); // Use deleteItem method from methods file
                  },
                ),
              ],
            ),
            onTap: () {
              showDetailView(context, item);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    super.dispose();
  }
}
