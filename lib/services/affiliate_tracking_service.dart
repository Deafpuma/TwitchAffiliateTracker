import 'package:cloud_firestore/cloud_firestore.dart';

class AffiliateTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addAffiliateClick(String userId, String productId, String affiliateLink) async {
    await _db.collection('affiliate_clicks').add({
      'userId': userId,
      'productId': productId,
      'affiliateLink': affiliateLink,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getAffiliateClicks(String userId) {
    return _db.collection('affiliate_clicks').where('userId', isEqualTo: userId).orderBy('timestamp', descending: true).snapshots();
  }
}
