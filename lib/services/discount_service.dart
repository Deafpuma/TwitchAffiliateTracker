import 'package:cloud_firestore/cloud_firestore.dart';

class DiscountService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDiscount(String title, String details, String code, String link) async {
    await _db.collection('discounts').add({
      'title': title,
      'details': details,
      'code': code,
      'link': link,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getDiscounts() {
    return _db.collection('discounts').orderBy('timestamp', descending: true).snapshots();
  }
}
