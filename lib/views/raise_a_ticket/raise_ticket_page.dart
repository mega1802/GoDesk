import 'package:flutter/material.dart';
import 'package:mydevice/models/ticket_model.dart';
import 'package:mydevice/views/ticket_view/ticket_view%20page.dart';

import 'ticket_manager_page.dart';

class RaiseTicketPage extends StatefulWidget {
  @override
  _RaiseTicketPageState createState() => _RaiseTicketPageState();
}

class _RaiseTicketPageState extends State<RaiseTicketPage> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  String? _assetType;
  String? _assetSubType;
  String? _issueType;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raise Ticket'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _assetType,
                onChanged: (value) {
                  setState(() {
                    _assetType = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Asset Type'),
                items: <String>[
                  "78578784785",
                  '78589678555',
                  '45567777775',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                value: _assetSubType,
                onChanged: (value) {
                  setState(() {
                    _assetSubType = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Asset Sub Type'),
                items: <String>[
                  "Display",
                  'Battery',
                  'Connectivity',
                  'Touch Pad',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                value: _issueType,
                onChanged: (value) {
                  setState(() {
                    _issueType = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Issue Type'),
                items: <String>[
                  'Display not working',
                  'Battery draining quickly',
                  'Connectivity issues',
                  'Touch pad not working',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the ticket to the list
                    ticketManager.tickets.add(
                      Ticket(
                        assetType: _assetType ?? '',
                        assetSubType: _assetSubType ?? '',
                        issueType: _issueType ?? '',
                        description: _description,
                        status: 'Pending',
                        date: DateTime.now().toString(),
                      ),
                    );

                    // Navigate to TicketViewPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketViewPage(),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

