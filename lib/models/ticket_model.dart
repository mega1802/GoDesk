class Ticket {
  final int? id;
  final String assetType;
  final String assetSubType;
  final String issueType;
  final String description;
  final String status;
  final String date;

  Ticket({
    this.id,
    required this.assetType,
    required this.assetSubType,
    required this.issueType,
    required this.description,
    required this.status,
    required this.date,
  });

  // Convert a Ticket object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assetType': assetType,
      'assetSubType': assetSubType,
      'issueType': issueType,
      'description': description,
      'status': status,
      'date': date,
    };
  }

  // Extract a Ticket object from a Map object
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      assetType: map['assetType'],
      assetSubType: map['assetSubType'],
      issueType: map['issueType'],
      description: map['description'],
      status: map['status'],
      date: map['date'],
    );
  }
}
