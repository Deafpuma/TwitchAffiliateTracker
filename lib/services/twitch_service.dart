import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TwitchService {
  final String clientId = dotenv.env['TWITCH_CLIENT_ID'] ?? "";
  final String clientSecret = dotenv.env['TWITCH_CLIENT_SECRET'] ?? "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("❌ User not authenticated");

      final userDoc = await _firestore.collection("users").doc(user.uid).get();
      final String? accessToken = userDoc.data()?["twitch_oauth_token"];

      if (accessToken == null) throw Exception("❌ No valid Twitch access token stored!");

      final response = await http.get(
        Uri.parse('https://api.twitch.tv/helix/users'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Client-Id': clientId,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'][0];
      } else {
        throw Exception("❌ Failed to fetch Twitch user data: ${response.body}");
      }
    } catch (e) {
      print("❌ Error fetching Twitch data: $e");
      return {};
    }
  }
}
