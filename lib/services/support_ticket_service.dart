import 'package:cloud_firestore/cloud_firestore.dart';

class SupportTicketService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitTicket(String userId, String issue) async {
    await _db.collection('support_tickets').add({
      'userId': userId,
      'issue': issue,
      'status': 'open',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getTickets(String userId) {
    return _db.collection('support_tickets').where('userId', isEqualTo: userId).orderBy('timestamp', descending: true).snapshots();
  }
}
