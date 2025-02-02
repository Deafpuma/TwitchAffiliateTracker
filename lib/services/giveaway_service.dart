import 'package:cloud_firestore/cloud_firestore.dart';

class GiveawayService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createGiveaway(String organizerId, String prize, DateTime endDate) async {
    await _db.collection('giveaways').add({
      'organizerId': organizerId,
      'prize': prize,
      'endDate': endDate.toIso8601String(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getActiveGiveaways() {
    return _db.collection('giveaways')
        .where('endDate', isGreaterThan: DateTime.now().toIso8601String())
        .orderBy('endDate', descending: false)
        .snapshots();
  }
}
