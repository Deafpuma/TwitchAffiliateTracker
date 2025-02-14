import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 Save User Data in Firestore
  Future<void> saveUserData(String userId, Map<String, dynamic> userData) async {
    try {
      await _db.collection("users").doc(userId).set(userData, SetOptions(merge: true));
    } catch (e) {
      print("Firestore Error: $e");
    }
  }

  // 🔹 Fetch User Data from Firestore
  Future<DocumentSnapshot?> getUserData(String userId) async {
    try {
      return await _db.collection("users").doc(userId).get();
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // 🔹 Save Stream History in Firestore
  Future<void> saveStreamHistory(String userId, Map<String, dynamic> streamData) async {
    try {
      String streamId = _db.collection("stream_history").doc().id;
      streamData['user_id'] = "/users/$userId";
      await _db.collection("stream_history").doc(streamId).set(streamData);
    } catch (e) {
      print("Error saving stream history: $e");
    }
  }

  // 🔹 Save Twitch OAuth Token
  Future<void> saveTwitchToken(String userId, String twitchToken) async {
    try {
      await _db.collection("users").doc(userId).update({
        "twitch_oauth_token": twitchToken,
      });
    } catch (e) {
      print("Error saving Twitch OAuth Token: $e");
    }
  }
}
