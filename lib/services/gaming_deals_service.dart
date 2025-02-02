import 'package:cloud_firestore/cloud_firestore.dart';

class GamingDealsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addGamingDeal(String title, String description, String link, DateTime expiryDate) async {
    await _db.collection('gaming_deals').add({
      'title': title,
      'description': description,
      'link': link,
      'expiryDate': expiryDate.toIso8601String(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getActiveDeals() {
    return _db.collection('gaming_deals')
        .where('expiryDate', isGreaterThan: DateTime.now().toIso8601String())
        .orderBy('expiryDate', descending: false)
        .snapshots();
  }
}
