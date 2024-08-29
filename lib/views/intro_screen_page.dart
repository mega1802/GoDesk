import 'package:flutter/material.dart';
import 'package:mydevice/constants/app_image.dart';
import 'auth/log_in_page.dart';

class IntroScreenPage extends StatelessWidget {
  const IntroScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intro Screen'),
        backgroundColor: Colors.blue, // Customize as needed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image from assets/images/logo.png
            Image.asset(
              AppImages.img1,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            


            const SizedBox(height: 20),
            const Text(
              'Welcome to Our App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
             const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your next page
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

// Define a placeholder for the next page

