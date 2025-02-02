import 'package:cloud_firestore/cloud_firestore.dart';

class StreamPremiumSubscriberBenefitsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addPremiumBenefit(String userId, String benefitTitle, String description) async {
    await _db.collection('premium_subscriber_benefits').add({
      'userId': userId,
      'benefitTitle': benefitTitle, // Example: "Exclusive Monthly Q&A", "Custom Emotes"
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getPremiumBenefits(String userId) {
    return _db
        .collection('premium_subscriber_benefits')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
