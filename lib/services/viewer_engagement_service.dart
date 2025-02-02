import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerEngagementService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addEngagement(String userId, String engagementType, String details) async {
    await _db.collection('viewer_engagements').add({
      'userId': userId,
      'engagementType': engagementType,
      'details': details,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserEngagements(String userId) {
    return _db.collection('viewer_engagements')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
