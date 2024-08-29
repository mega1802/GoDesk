

import 'package:mydevice/models/assets_model.dart';

class AssetManager {
  static final AssetManager _instance = AssetManager._internal();
  factory AssetManager() => _instance;
  AssetManager._internal();

  final List<Asset> assets = [];
}

final assetManager = AssetManager();
