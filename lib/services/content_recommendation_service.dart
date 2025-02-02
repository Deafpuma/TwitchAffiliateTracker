import 'package:cloud_firestore/cloud_firestore.dart';

class ContentRecommendationService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addRecommendation(String userId, String recommendedContentId, String reason) async {
    await _db.collection('content_recommendations').add({
      'userId': userId,
      'recommendedContentId': recommendedContentId,
      'reason': reason,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getRecommendations(String userId) {
    return _db.collection('content_recommendations')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
