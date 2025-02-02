import 'package:cloud_firestore/cloud_firestore.dart';

class StreamGrowthInsightsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> logGrowthInsight(
      String userId, int newFollowers, int peakViewers, String topGame) async {
    await _db.collection('stream_growth_insights').add({
      'userId': userId,
      'newFollowers': newFollowers,
      'peakViewers': peakViewers,
      'topGame': topGame,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getGrowthInsights(String userId) {
    return _db
        .collection('stream_growth_insights')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
