import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionTierService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSubscriptionTier(String tierName, double price, String benefits) async {
    await _db.collection('subscription_tiers').add({
      'tierName': tierName,
      'price': price,
      'benefits': benefits,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getSubscriptionTiers() {
    return _db.collection('subscription_tiers')
        .orderBy('price', descending: false)
        .snapshots();
  }
}
