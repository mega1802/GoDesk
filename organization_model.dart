class OrganizationModel {
  int? id;
  String name;
  String adminFirstName;
  String adminLastName;
  String? type;
  String? category;
  String? size;
  String? gstNo;
  String? msmeNo;
  String? contactNo;
  String? address;

  OrganizationModel({
    this.id,
    required this.name,
    required this.adminFirstName,
    required this.adminLastName,
    this.type,
    this.category,
    this.size,
    this.gstNo,
    this.msmeNo,
    this.contactNo,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'admin_first_name': adminFirstName,
      'admin_last_name': adminLastName,
      'type': type ?? '',  // Default to empty string if null
      'category': category ?? '',
      'size': size ?? '',
      'gst_no': gstNo ?? '',
      'msme_no': msmeNo ?? '',
      'contact_no': contactNo ?? '',
      'address': address ?? '',
    };
  }

  static OrganizationModel fromMap(Map<String, dynamic> map) {
    return OrganizationModel(
      id: map['id'],
      name: map['name'],
      adminFirstName: map['admin_first_name'],
      adminLastName: map['admin_last_name'],
      type: map['type'],
      category: map['category'],
      size: map['size'],
      gstNo: map['gst_no'],
      msmeNo: map['msme_no'],
      contactNo: map['contact_no'],
      address: map['address'],
    );
  }
}
