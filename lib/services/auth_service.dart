import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithTwitch() async {
    try {
      print("🔄 Attempting Twitch Login...");

      final OAuthProvider provider = OAuthProvider("oidc.twitch");
      provider.addScope("openid");
      provider.addScope("user:read:email");

      // 🔥 Sign in using Firebase Auth
      final UserCredential credential = await _auth.signInWithProvider(provider);
      final User? user = credential.user;

      if (user == null) throw Exception("❌ User authentication failed!");

      // ✅ Get OAuth Credentials
      final OAuthCredential? twitchCred = credential.credential as OAuthCredential?;
      final String? accessToken = twitchCred?.accessToken;
      final String? idToken = twitchCred?.idToken; // Twitch doesn't always return refresh tokens

      if (accessToken == null || idToken == null) {
        throw Exception("❌ Failed to retrieve Twitch tokens.");
      }

      // 🔥 Save to Firestore
      await _firestore.collection("users").doc(user.uid).set({
        "email": user.email ?? "",
        "displayName": user.displayName ?? "",
        "photoURL": user.photoURL ?? "",
        "twitch_oauth_token": accessToken,
        "twitch_refresh_token": idToken, // Not always returned
        "created_at": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print("✅ Twitch authentication successful!");
    } catch (e) {
      print("❌ Twitch Authentication Error: $e");
    }
  }

  /// Logout
  Future<void> signOut() async {
    await _auth.signOut();
    print("✅ Successfully signed out");
  }
}
