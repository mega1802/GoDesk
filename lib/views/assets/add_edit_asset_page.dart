import 'package:flutter/material.dart';
import 'package:mydevice/models/assets_model.dart';
class EditAssetPage extends StatefulWidget {
  final Asset asset;
  EditAssetPage({required this.asset});
  @override
  _EditAssetPageState createState() => _EditAssetPageState();
}
class _EditAssetPageState extends State<EditAssetPage> {
  final _formKey = GlobalKey<FormState>();
  late String _assetType;
  late String _modelName;
  late String _modelNo;
  late String _serialNo;
  @override
  void initState() {
    super.initState();
    _assetType = widget.asset.assetType;
    _modelName = widget.asset.modelName;
    _modelNo = widget.asset.modelNo;
    _serialNo = widget.asset.serialNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Asset'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                value: _assetType,
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
                initialValue: _modelName,
                decoration: InputDecoration(labelText: 'Model Name'),
                onChanged: (value) {
                  setState(() {
                    _modelName = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter model name' : null,
              ),
              TextFormField(
                initialValue: _modelNo,
                decoration: InputDecoration(labelText: 'Model No'),
                onChanged: (value) {
                  setState(() {
                    _modelNo = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter model no' : null,
              ),
              TextFormField(
                initialValue: _serialNo,
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
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}