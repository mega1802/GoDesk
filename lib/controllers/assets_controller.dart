import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController modelNameController = TextEditingController();
  final TextEditingController modelNoController = TextEditingController();
  final TextEditingController serialNoController = TextEditingController();

  // Method to handle search functionality
  void searchAssets() {
    String searchQuery = searchController.text;
    // Implement search functionality
    print('Search for: $searchQuery');
  }

  // Method to handle adding a new asset
  void addAsset(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle adding new asset
      print('Adding new asset');
      // Clear form fields
      typeController.clear();
      modelNameController.clear();
      modelNoController.clear();
      serialNoController.clear();
      Navigator.of(context).pop(); // Close the dialog

    }
  }

  // Method to show the Add Asset dialog
  void showAddAssetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Asset'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter asset type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: modelNameController,
                decoration: InputDecoration(labelText: 'Model Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: modelNoController,
                decoration: InputDecoration(labelText: 'Model Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: serialNoController,
                decoration: InputDecoration(labelText: 'Serial Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter serial number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => addAsset(context),
            child: Text('Add'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
