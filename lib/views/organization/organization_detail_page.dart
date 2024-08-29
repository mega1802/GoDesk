import 'package:flutter/material.dart';
import 'package:mydevice/constants/app_image.dart';
import 'package:mydevice/models/organization_model.dart';
import 'package:mydevice/views/organization/organization_edit_page.dart';
import 'package:mydevice/views/organization/organization_manager_page.dart';

class OrganizationDetailPage extends StatefulWidget {
  final OrganizationModel organization;

  const OrganizationDetailPage({Key? key, required this.organization}) : super(key: key);

  @override
  _OrganizationDetailPageState createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  late OrganizationModel organization;

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }

  Future<void> _updateOrganization(OrganizationModel updatedOrganization) async {
    try {
      // Update in OrganizationManager
      final index = organizationManager.organizations.indexWhere((org) => org.id == updatedOrganization.id);
      if (index != -1) {
        organizationManager.organizations[index] = updatedOrganization;
      }
    } catch (e) {
      // Handle errors if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Detail'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedOrganization = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOrganizationPage(organization: organization),
                ),
              );

              if (updatedOrganization != null) {
                setState(() {
                  organization = updatedOrganization;
                });

                await _updateOrganization(updatedOrganization);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.org,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Organization Details:', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Organization Name: ${organization.name}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('Admin First Name: ${organization.adminFirstName}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('Admin Last Name: ${organization.adminLastName}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('Type: ${organization.type}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('Category: ${organization.category}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('Size: ${organization.size}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('GST No: ${organization.gstNo}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('MSME No: ${organization.msmeNo}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Text('Contact Details:', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Contact No: ${organization.contactNo}', style: const TextStyle(fontSize: 18)),
            const Divider(),
            const SizedBox(height: 10),
            Text('Address: ${organization.address}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
