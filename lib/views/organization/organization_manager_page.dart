import 'package:mydevice/models/organization_model.dart';

class OrganizationManager {
  static final OrganizationManager _instance = OrganizationManager._internal();
  factory OrganizationManager() => _instance;
  OrganizationManager._internal();

  final List<OrganizationModel> organizations = [];
}

final organizationManager = OrganizationManager();
