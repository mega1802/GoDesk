// edit_user_profile_page.dart
import 'package:flutter/material.dart';

class EditUserProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String alternateNumber;
  final String organization;
  final Function(String, String, String, String, String) onSave;

  EditUserProfilePage({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.alternateNumber,
    required this.organization,
    required this.onSave,
  });

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _phoneNumber;
  late String _alternateNumber;
  late String _organization;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
    _phoneNumber = widget.phoneNumber;
    _alternateNumber = widget.alternateNumber;
    _organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                initialValue: _phoneNumber,
                decoration: InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              TextFormField(
                initialValue: _alternateNumber,
                decoration: InputDecoration(labelText: 'Alternate Phone Number'),
                onChanged: (value) {
                  setState(() {
                    _alternateNumber = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter an alternate phone number' : null,
              ),
              TextFormField(
                initialValue: _organization,
                decoration: InputDecoration(labelText: 'Organization'),
                onChanged: (value) {
                  setState(() {
                    _organization = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter your organization' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(_name, _email, _phoneNumber, _alternateNumber, _organization);
                    Navigator.pop(context);
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
