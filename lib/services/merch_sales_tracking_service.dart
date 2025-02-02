import 'package:cloud_firestore/cloud_firestore.dart';

class MerchSalesTrackingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logMerchSale(String userId, String productName, double price, int quantity) async {
    await _db.collection('merch_sales').add({
      'userId': userId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'totalRevenue': price * quantity,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserMerchSales(String userId) {
    return _db
        .collection('merch_sales')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
