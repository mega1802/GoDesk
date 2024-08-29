import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydevice/models/organization_model.dart';
import 'package:mydevice/views/home/home_screen_page.dart';
import 'package:mydevice/views/organization/organization_detail_page.dart';
import 'package:mydevice/views/profile/change_password_page.dart';
import 'package:mydevice/views/profile/edit_user_profile_page.dart';

class UserProfilePage extends StatefulWidget {
  final OrganizationModel organization;

  UserProfilePage({Key? key, required this.organization}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _name = "John Doe";
  String _email = "john.doe@example.com";
  String _phoneNumber = "123-456-7890";
  String _alternateNumber = "098-765-4321";
  late OrganizationModel _organization;

  @override
  void initState() {
    super.initState();
    _organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenPage(organization: _organization)),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.teal,
                  child: Text(
                    _name[0],
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black54),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserProfilePage(
                          name: _name,
                          email: _email,
                          phoneNumber: _phoneNumber,
                          alternateNumber: _alternateNumber,
                          organization: _organization.name,
                          onSave: (name, email, phoneNumber, alternateNumber, organizationName) {
                            setState(() {
                              _name = name;
                              _email = email;
                              _phoneNumber = phoneNumber;
                              _alternateNumber = alternateNumber;
                              // Optionally, update _organization if needed
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Name: $_name',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Email: $_email',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Phone: $_phoneNumber',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Alternate Phone: $_alternateNumber',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrganizationDetailPage(
                      organization: _organization,
                    ),
                  ),
                );
              },
              child: Text(
                'Organization: ${_organization.name}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(),
                  ),
                );
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
