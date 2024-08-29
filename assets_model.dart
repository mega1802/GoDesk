class Asset {
  final int? id;
  final String assetType;
  final String modelName;
  final String modelNo;
  final String serialNo;

  Asset({
    this.id,
    required this.assetType,
    required this.modelName,
    required this.modelNo,
    required this.serialNo,
  });

  // Convert a Asset into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assetType': assetType,
      'modelName': modelName,
      'modelNo': modelNo,
      'serialNo': serialNo,
    };
  }

  // Convert a Map into an Asset
  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'],
      assetType: map['assetType'],
      modelName: map['modelName'],
      modelNo: map['modelNo'],
      serialNo: map['serialNo'],
    );
  }
}
