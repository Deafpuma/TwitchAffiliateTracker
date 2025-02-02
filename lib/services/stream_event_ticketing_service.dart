import 'package:cloud_firestore/cloud_firestore.dart';

class StreamEventTicketingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createEventTicket(String userId, String eventTitle, double ticketPrice, int totalTickets) async {
    await _db.collection('event_tickets').add({
      'userId': userId,
      'eventTitle': eventTitle,
      'ticketPrice': ticketPrice,
      'totalTickets': totalTickets,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getEventTickets(String userId) {
    return _db
        .collection('event_tickets')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
