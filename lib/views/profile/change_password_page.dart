// change_password_page.dart
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late String _currentPassword;
  late String _newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _currentPassword = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter your current password' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _newPassword = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Please enter a new password' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add logic to change the password here
                    Navigator.pop(context);
                  }
                },
                child: Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
