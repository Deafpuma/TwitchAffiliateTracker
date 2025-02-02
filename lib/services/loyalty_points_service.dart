import 'package:cloud_firestore/cloud_firestore.dart';

class LoyaltyPointsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addPoints(String userId, int points) async {
    final userRef = _db.collection('users').doc(userId);
    final userSnapshot = await userRef.get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      int currentPoints = (userSnapshot.data()?['loyaltyPoints'] ?? 0) as int;
      await userRef.update({'loyaltyPoints': currentPoints + points});
    } else {
      await userRef.set({'loyaltyPoints': points});
    }
  }

  Future<int> getPoints(String userId) async {
    final userSnapshot = await _db.collection('users').doc(userId).get();
    if (userSnapshot.exists && userSnapshot.data() != null) {
      return (userSnapshot.data()?['loyaltyPoints'] ?? 0) as int;
    }
    return 0;
  }

  Future<void> redeemPoints(String userId, int points) async {
    final userRef = _db.collection('users').doc(userId);
    final userSnapshot = await userRef.get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      int currentPoints = (userSnapshot.data()?['loyaltyPoints'] ?? 0) as int;
      if (currentPoints >= points) {
        await userRef.update({'loyaltyPoints': currentPoints - points});
      } else {
        throw Exception("Not enough points to redeem.");
      }
    } else {
      throw Exception("User does not exist.");
    }
  }
}
