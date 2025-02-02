import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String clientId = dotenv.env['TWITCH_CLIENT_ID']!;
  final String redirectUri = dotenv.env['TWITCH_REDIRECT_URI']!;

  Future<String> getAuthUrl() async {
    return "https://id.twitch.tv/oauth2/authorize?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=user:read:email";
  }

  Future<User?> signInWithTwitch(String code) async {
    final response = await http.post(
      Uri.parse('https://id.twitch.tv/oauth2/token'),
      body: {
        'client_id': clientId,
        'client_secret': dotenv.env['TWITCH_CLIENT_SECRET']!,
        'code': code,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String accessToken = data['access_token'];
      final String idToken = data['id_token'];

      final AuthCredential credential = OAuthProvider("twitch.com").credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } else {
      throw Exception('Failed to sign in with Twitch');
    }
  }
}
