import 'package:flutter/material.dart';
import 'package:mydevice/models/organization_model.dart';

class EditOrganizationPage extends StatefulWidget {
  final OrganizationModel organization;

  const EditOrganizationPage({Key? key, required this.organization}) : super(key: key);

  @override
  _EditOrganizationPageState createState() => _EditOrganizationPageState();
}

class _EditOrganizationPageState extends State<EditOrganizationPage> {
  late TextEditingController nameController;
  late TextEditingController adminFirstNameController;
  late TextEditingController adminLastNameController;
  late TextEditingController typeController;
  late TextEditingController categoryController;
  late TextEditingController sizeController;
  late TextEditingController gstNoController;
  late TextEditingController msmeNoController;
  late TextEditingController contactNoController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final organization = widget.organization;
    nameController = TextEditingController(text: organization.name);
    adminFirstNameController = TextEditingController(text: organization.adminFirstName);
    adminLastNameController = TextEditingController(text: organization.adminLastName);
    typeController = TextEditingController(text: organization.type);
    categoryController = TextEditingController(text: organization.category);
    sizeController = TextEditingController(text: organization.size);
    gstNoController = TextEditingController(text: organization.gstNo);
    msmeNoController = TextEditingController(text: organization.msmeNo);
    contactNoController = TextEditingController(text: organization.contactNo);
    addressController = TextEditingController(text: organization.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    adminFirstNameController.dispose();
    adminLastNameController.dispose();
    typeController.dispose();
    categoryController.dispose();
    sizeController.dispose();
    gstNoController.dispose();
    msmeNoController.dispose();
    contactNoController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Organization'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Organization Name',
              ),
            ),
            TextField(
              controller: adminFirstNameController,
              decoration: const InputDecoration(
                labelText: 'Admin First Name',
              ),
            ),
            TextField(
              controller: adminLastNameController,
              decoration: const InputDecoration(
                labelText: 'Admin Last Name',
              ),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            TextField(
              controller: sizeController,
              decoration: const InputDecoration(
                labelText: 'Size',
              ),
            ),
            TextField(
              controller: gstNoController,
              decoration: const InputDecoration(
                labelText: 'GST No',
              ),
            ),
            TextField(
              controller: msmeNoController,
              decoration: const InputDecoration(
                labelText: 'MSME No',
              ),
            ),
            TextField(
              controller: contactNoController,
              decoration: const InputDecoration(
                labelText: 'Contact No',
              ),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final updatedOrganization = OrganizationModel(
            name: nameController.text,
            adminFirstName: adminFirstNameController.text,
            adminLastName: adminLastNameController.text,
            type: typeController.text,
            category: categoryController.text,
            size: sizeController.text,
            gstNo: gstNoController.text,
            msmeNo: msmeNoController.text,
            contactNo: contactNoController.text,
            address: addressController.text,
          );

          Navigator.pop(context, updatedOrganization);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
