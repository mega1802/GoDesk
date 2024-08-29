import 'dart:math';

import 'package:flutter/material.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  _OtpVerificationPage createState() => _OtpVerificationPage();
}

class _OtpVerificationPage extends State<OtpVerificationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Mock data for storing OTPs
  Map<String, String?> mockOtpData = {};

  @override
  void initState() {
    super.initState();
  }

  Future<bool> sendOTP(String email) async {
    // Mock sending OTP
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Generate a mock OTP
    String otp = generateOtp();
    mockOtpData[email] = otp; // Store OTP in mock data

    // Print the OTP to the console
    print("OTP sent to $email: $otp");

    return true;
  }

  Future<bool> verifyOTP(String otp) async {
    // Mock verifying OTP
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Check if the OTP matches
    String? storedOtp = mockOtpData[emailController.text];
    if (storedOtp == otp) {
      return true;
    }
    return false;
  }

  Future<bool> resetPassword(String newPassword) async {
    // Mock resetting the password
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Print the new password to the console (for demonstration purposes)
    print("Password reset to: $newPassword");

    return true;
  }

  String generateOtp({int length = 6}) {
    final Random random = Random();
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email OTP')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Enter your email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter an email address")),
                );
                return;
              }

              try {
                bool success = await sendOTP(emailController.text);
                String message = success ? "OTP has been sent" : "OTP failed to send";
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error sending OTP: ${e.toString()}")));
              }
            },
            child: const Text('Send OTP'),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: otpController,
            decoration: const InputDecoration(labelText: 'Enter the OTP'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (otpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter the OTP")),
                );
                return;
              }

              try {
                bool verified = await verifyOTP(otpController.text);
                if (verified) {
                  // Show password reset fields
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Reset Password'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: newPasswordController,
                              decoration: const InputDecoration(labelText: 'New Password'),
                              obscureText: true,
                            ),
                            TextFormField(
                              controller: confirmPasswordController,
                              decoration: const InputDecoration(labelText: 'Confirm Password'),
                              obscureText: true,
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              if (newPasswordController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please fill in both fields")),
                                );
                                return;
                              }

                              if (newPasswordController.text != confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Passwords do not match")),
                                );
                                return;
                              }

                              bool passwordReset = await resetPassword(newPasswordController.text);
                              if (passwordReset) {
                                Navigator.of(context).pop(); // Close the dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Password reset successfully")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Error resetting password")),
                                );
                              }
                            },
                            child: const Text('Reset Password'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP verification failed")));
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error verifying OTP: ${e.toString()}")));
              }
            },
            child: const Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}
