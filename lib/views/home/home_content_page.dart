import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydevice/models/organization_model.dart';
import 'package:mydevice/views/assets/assets_card.dart';
import 'package:mydevice/views/assets/assets_list_page.dart';
import 'package:mydevice/views/godesk_menu/help_support_page.dart';
import 'package:mydevice/views/home/need_assests_page.dart';
import 'package:mydevice/views/organization/organization_card_page.dart';
import 'package:mydevice/views/organization/organization_detail_page.dart';
import 'package:mydevice/views/raise_a_ticket/raise_ticket_page.dart';

import 'trouble_device_card_page.dart';

class HomeContent extends StatelessWidget {
  final OrganizationModel organization;

  HomeContent({Key? key, required this.organization}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Hello User Name 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'How can we assist you today?',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            Divider(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RaiseTicketPage(),
                  ),
                );
              },
              child: TroubleWithDeviceCard(),
            ),
            Divider(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrganizationDetailPage(
                            organization: organization,
                          ),
                        ),
                      );
                    },
                    child: OrganizationCard(),
                  ),
                ),
                Divider(),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssetsListPage(),
                        ),
                      );
                    },
                    child: AssetsCard(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpSupportPage(),
                  ),
                );
              },
              child: NeedAssistanceCard(),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
