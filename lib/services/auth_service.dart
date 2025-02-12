import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      await _checkAndStoreUser(userCredential.user);
      return userCredential.user;
    } catch (e) {
      print("Google Sign-in error: $e");
      return null;
    }
  }

  // 🔹 Sign in with Twitch
  Future<User?> signInWithTwitch() async {
    try {
      final OAuthProvider twitchProvider = OAuthProvider("oidc.twitch");

      // ✅ Use `signInWithProvider` (works on mobile)
      UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(twitchProvider);

      // ✅ Store user details in Firestore
      await _checkAndStoreUser(userCredential.user);
      return userCredential.user;
    } catch (e) {
      print("Twitch Sign-in error: $e");
      return null;
    }
  }


  // 🔹 Sign up with Email & Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _checkAndStoreUser(userCredential.user);
      return userCredential.user;
    } catch (e) {
      print("Email Sign-up error: $e");
      return null;
    }
  }

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
        "subscription": "free", // Default plan
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
    await _googleSignIn.signOut();
  }
}
