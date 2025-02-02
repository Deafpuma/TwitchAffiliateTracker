import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCommunityFundraiserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createFundraiser(String userId, String fundraiserTitle, double goalAmount, String description) async {
    await _db.collection('community_fundraisers').add({
      'userId': userId,
      'fundraiserTitle': fundraiserTitle,
      'goalAmount': goalAmount,
      'description': description,
      'amountRaised': 0.0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateFundraiserAmount(String fundraiserId, double amount) async {
    final fundraiserRef = _db.collection('community_fundraisers').doc(fundraiserId);
    final fundraiserSnapshot = await fundraiserRef.get();
    if (fundraiserSnapshot.exists) {
      double currentAmount = fundraiserSnapshot.data()?['amountRaised'] ?? 0.0;
      await fundraiserRef.update({'amountRaised': currentAmount + amount});
    }
  }

  Stream<QuerySnapshot> getFundraisers(String userId) {
    return _db
        .collection('community_fundraisers')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
