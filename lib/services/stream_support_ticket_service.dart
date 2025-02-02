import 'package:cloud_firestore/cloud_firestore.dart';

class StreamSupportTicketService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitSupportTicket(String userId, String viewerId, String issueDescription) async {
    await _db.collection('support_tickets').add({
      'userId': userId,
      'viewerId': viewerId,
      'issueDescription': issueDescription,
      'status': 'Open', // Options: Open, In Progress, Resolved
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTicketStatus(String ticketId, String status) async {
    await _db.collection('support_tickets').doc(ticketId).update({'status': status});
  }

  Stream<QuerySnapshot> getSupportTickets(String userId) {
    return _db
        .collection('support_tickets')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
