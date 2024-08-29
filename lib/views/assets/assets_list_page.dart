
import 'package:flutter/material.dart';
import 'package:mydevice/models/assets_model.dart';
import 'package:mydevice/views/assets/add_edit_asset_page.dart';
import 'package:mydevice/views/assets/assets_detail_page.dart';
class AssetsListPage extends StatefulWidget {
  @override
  _AssetsListPageState createState() => _AssetsListPageState();
}

class _AssetsListPageState extends State<AssetsListPage> {
  List<Asset> assets = [];

  void _addAsset(Asset asset) {
    setState(() {
      assets.add(asset);
    });
  }

  void _editAsset(int index, Asset asset) {
    setState(() {
      assets[index] = asset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by Serial Number',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final newAsset = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAssetPage(),
                      ),
                    );
                    if (newAsset != null) {
                      _addAsset(newAsset);
                    }
                  },

                  child: Text('Add Asset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(assets[index].modelName),
                    subtitle: Text('Serial No: ${assets[index].serialNo}'),
                    trailing: Text('Type: ${assets[index].assetType}'),
                    onTap: () async {
                      final editedAsset = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAssetPage(asset: assets[index]),
                        ),
                      );
                      if (editedAsset != null) {
                        _editAsset(index, editedAsset);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
