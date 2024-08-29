import 'package:flutter/material.dart';
import 'package:mydevice/models/ticket_model.dart';
import 'package:mydevice/views/raise_a_ticket/raise_ticket_page.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  TicketDetailPage({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Asset Type: ${ticket.assetType}', style: TextStyle(fontSize: 16)),
            Text('Asset Sub Type: ${ticket.assetSubType}', style: TextStyle(fontSize: 16)),
            Text('Issue Type: ${ticket.issueType}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Description:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(ticket.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
