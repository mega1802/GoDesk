import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeedAssistanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.help_outline, size: 40, color: Colors.orange[700]),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need Assistance..',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Reach Out to Us!',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.arrow_forward, color: Colors.orange[700]),
        ],
      ),
    );
  }
}
