import 'package:flutter/material.dart';
import 'package:mydevice/models/organization_model.dart'; // Import the model for organization
import 'package:mydevice/views/auth/auth_service_page.dart'; // Adjust import if necessary
import 'package:mydevice/views/auth/log_in_page.dart';

class CompleteInfoPage extends StatefulWidget {
  @override
  _CompleteInfoPageState createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$',
    caseSensitive: false,
  );
  final RegExp password = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _organizationNameController = TextEditingController();

  bool _isObscure = true;

  // Create an instance of AuthService
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Your Information'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (!password.hasMatch(value)) {
                    return 'Password must be at least 8 characters long and include both letters and numbers';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                "Organization Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _organizationNameController,
                decoration: InputDecoration(
                  labelText: 'Organization Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your organization name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Register the user
                        await authService.registerUser(
                         _firstNameController.text,
                          _lastNameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );

                        // Register the organization
                        OrganizationModel organization = OrganizationModel(
                          name: _organizationNameController.text,
                          adminFirstName: _firstNameController.text,
                          adminLastName: _lastNameController.text, type: '', category: '', size: '', gstNo: '', msmeNo: '', contactNo: '', address: '',
                          // Add other necessary fields here
                        );
                        await authService.registerOrganization(organization);

                        // Navigate to LoginPage after successful registration
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration error: $e')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
