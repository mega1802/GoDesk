import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydevice/models/organization_model.dart';
import 'package:mydevice/services/api_service.dart'; // Ensure this is correctly imported
import 'package:mydevice/views/verify/otp_verification_page.dart';
import '../home/home_screen_page.dart';
import 'complete_info_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length > 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back! 👋",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Enter your details to continue where you left off",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 35),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')), // Disallow whitespace
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtpVerificationPage()),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;

                  if (_isValidEmail(email) && _isPasswordValid(password)) {
                    try {
                      bool isRegistered = await dbHelper.getUserByEmailAndPassword(email, password).then((result) => result.isNotEmpty);
                      if (isRegistered) {
                        // Create or fetch an organization instance
                        OrganizationModel organization = OrganizationModel(name: '', adminFirstName: '',adminLastName: '',  category: '' , type: '', size: '', gstNo: '', contactNo: '', msmeNo: '', address: ''                         // Populate with actual data
                                  );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreenPage(
                              organization: organization,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid email or password')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Database error: $e')),
                      );
                    }
                  } else {
                    String message = '';
                    if (!_isValidEmail(email)) {
                      message += 'Invalid email format. ';
                    }
                    if (!_isPasswordValid(password)) {
                      message += 'Password must be at least 9 characters.';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompleteInfoPage(),
                        ),
                      );
                    },
                    child: Text('Register Now'),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'By Logging in I accept the',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  // Handle terms and conditions
                },
                child: Text(
                  'Terms & condition and Privacy policy',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
