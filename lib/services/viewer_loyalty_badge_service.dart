import 'package:cloud_firestore/cloud_firestore.dart';

class ViewerLoyaltyBadgeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> assignLoyaltyBadge(String userId, String viewerId, String badgeType) async {
    await _db.collection('viewer_loyalty_badges').add({
      'userId': userId,
      'viewerId': viewerId,
      'badgeType': badgeType,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getViewerBadges(String viewerId) {
    return _db
        .collection('viewer_loyalty_badges')
        .where('viewerId', isEqualTo: viewerId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
