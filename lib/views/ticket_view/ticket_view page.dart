import 'package:flutter/material.dart';
import 'package:mydevice/views/raise_a_ticket/ticket_detail_page.dart';
import 'package:mydevice/views/raise_a_ticket/ticket_manager_page.dart';

class TicketViewPage extends StatefulWidget {
  const TicketViewPage({super.key});

  @override
  State<TicketViewPage> createState() => _TicketViewPageState();
}

class _TicketViewPageState extends State<TicketViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Tickets'),
      ),
      body: ListView.builder(
        itemCount: ticketManager.tickets.length,
        itemBuilder: (context, index) {
          final ticket = ticketManager.tickets[index];
          return ListTile(
            title: Text('Asset Type: ${ticket.assetType}'),
            subtitle: Text('Asset sub Type: ${ticket.assetSubType}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketDetailPage(ticket: ticket),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
