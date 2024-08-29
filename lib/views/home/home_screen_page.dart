import 'package:flutter/material.dart';
import 'package:mydevice/models/organization_model.dart';
import 'package:mydevice/views/auth/log_in_page.dart';
import 'package:mydevice/views/home/home_content_page.dart';
import 'package:mydevice/views/profile/user_profile_page.dart';
import 'package:mydevice/views/assets/assets_card.dart';
import 'package:mydevice/views/godesk_menu/help_support_page.dart';

import 'package:mydevice/views/ticket_view/ticket_view%20page.dart';


class HomeScreenPage extends StatefulWidget {
  final OrganizationModel organization;

  HomeScreenPage({Key? key, required this.organization}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int _selectedIndex = 0;

  // The current page widget to display
  Widget _currentPage = Container(); // Initialize with an empty container

  @override
  void initState() {
    super.initState();
    _currentPage = HomeContent(organization: widget.organization); // Pass organization to HomeContent
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          _currentPage = HomeContent(organization: widget.organization);
        });
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketViewPage(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfilePage(
              organization: widget.organization,
            ),
          ),
        );
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoDesk'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'GoDesk Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
            ),
            ListTile(
                leading: Icon(Icons.help),
                title: Text('Help & Support'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpSupportPage(),
                    ),
                  );
                }
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Refer a Friend'),
            ),
            ListTile(
                leading: Icon(Icons.logout_sharp),
                title: Text('Log Out'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_sharp),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
