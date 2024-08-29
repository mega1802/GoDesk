import 'package:flutter/material.dart';
import 'package:mydevice/models/assets_model.dart';
import 'assets_manager_page.dart';

class AddAssetPage extends StatefulWidget {
  @override
  _AddAssetPageState createState() => _AddAssetPageState();
}

class _AddAssetPageState extends State<AddAssetPage> {
  final _formKey = GlobalKey<FormState>();

  String _assetType = '';
  String _modelName = '';
  String _modelNo = '';
  String _serialNo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Asset'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Select Device Type'),
                items: ['Desktop', 'Laptop', 'Tablet'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _assetType = newValue!;
                  });
                },
                validator: (value) => value == null ? 'Please select a type' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model Name'),
                onChanged: (value) {
                  setState(() {
                    _modelName = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter model name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model No'),
                onChanged: (value) {
                  setState(() {
                    _modelNo = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter model no' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Serial No'),
                onChanged: (value) {
                  setState(() {
                    _serialNo = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter serial no' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      Asset(
                        assetType: _assetType,
                        modelName: _modelName,
                        modelNo: _modelNo,
                        serialNo: _serialNo,
                      ),
                    );
                    assetManager.assets.add(Asset as Asset);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}