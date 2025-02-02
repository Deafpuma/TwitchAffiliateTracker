import 'package:cloud_firestore/cloud_firestore.dart';

class StreamSubscriberBenefitsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSubscriberBenefit(String userId, String benefitTitle, String description) async {
    await _db.collection('subscriber_benefits').add({
      'userId': userId,
      'benefitTitle': benefitTitle, // Example: "Exclusive Emotes", "Ad-Free Viewing"
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSubscriberBenefits(String userId) {
    return _db
        .collection('subscriber_benefits')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
