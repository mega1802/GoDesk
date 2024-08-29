import 'package:flutter/material.dart';
import 'package:mydevice/views/raise_a_ticket/raise_ticket_page.dart';

class TroubleWithDeviceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RaiseTicketPage()),
          );
        },

      child: Row(
        children: [
          Icon(Icons.build, size: 40, color: Colors.teal[700]),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trouble with Your Device?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Raise a ticket',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward, color: Colors.teal[700]),
        ],
      ),
    );
  }
}
