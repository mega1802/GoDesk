import 'package:mydevice/models/ticket_model.dart';

class TicketManager {
  static final TicketManager _instance = TicketManager._internal();
  factory TicketManager() => _instance;
  TicketManager._internal();

  final List<Ticket> tickets = [];
}

final ticketManager = TicketManager();
