import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Sign in with Email & Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _checkAndStoreUser(userCredential.user);
      return userCredential.user;
    } catch (e) {
      print("Email Sign-in error: $e");
      return null;
    }
  }

  // 🔹 Store User in Firestore and Check Subscription Status
  Future<void> _checkAndStoreUser(User? user) async {
    if (user == null) return;

    DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();

    if (!userDoc.exists) {
      await _firestore.collection("users").doc(user.uid).set({
        "email": user.email,
        "subscription": "free",
        "created_at": FieldValue.serverTimestamp(),
      });
    }
  }

  // 🔹 Get User Subscription Status
  Future<String> getUserSubscriptionStatus(User user) async {
    DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();
    if (userDoc.exists && userDoc.data() != null) {
      return (userDoc.data() as Map<String, dynamic>)["subscription"] ?? "free";
    }
    return "free";
  }

  // 🔹 Upgrade User to Paid Plan
  Future<void> upgradeToPaid(User user) async {
    await _firestore.collection("users").doc(user.uid).update({
      "subscription": "paid",
    });
  }

  // 🔹 Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
