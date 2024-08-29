import 'package:flutter/material.dart';

import '../../constants/app_image.dart';

class HelpSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        // Image from assets/images/logo.png
            Image.asset(
              AppImages.img2,
              width: 500,
              height: 300,
              fit: BoxFit.cover,
            ),


            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Us'),
              subtitle: Text('+91 9348477648'),
              onTap: () {
                // Implement call us functionality here, like launching the dialer
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Us'),
              subtitle: Text('support@gmail.com'),
              onTap: () {
                // Implement email us functionality here, like launching the email app
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQs'),
              onTap: () {
                // Show FAQ section or navigate to an FAQ page
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Frequently Asked Questions'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FAQItem(
                          question: 'How can I reset my password?',
                          answer:
                          'To reset your password, go to the login page and click on "Forgot Password". Follow the instructions sent to your registered email.',
                        ),
                        SizedBox(height: 10),
                        FAQItem(
                          question: 'How do I contact customer support?',
                          answer:
                          'You can contact customer support by calling us at +91 9348477648 or by emailing support@gmail.com.',
                        ),
                        SizedBox(height: 10),
                        FAQItem(
                          question: 'Where can I find the privacy policy?',
                          answer:
                          'The privacy policy can be found in the app menu under "Privacy Policy".',
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(answer),
      ],
    );
  }
}
