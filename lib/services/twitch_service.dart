import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TwitchService {
  final String clientId = dotenv.env['TWITCH_CLIENT_ID'] ?? "";
  final String clientSecret = dotenv.env['TWITCH_CLIENT_SECRET'] ?? "";
  String? accessToken;

  Future<void> authenticate() async {
    if (clientId.isEmpty || clientSecret.isEmpty) {
      throw Exception('Missing Twitch API credentials in .env file');
    }

    final response = await http.post(
      Uri.parse('https://id.twitch.tv/oauth2/token'),
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      accessToken = data['access_token'];
    } else {
      throw Exception('Failed to authenticate with Twitch: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserData(String username) async {
    if (accessToken == null) await authenticate();

    final response = await http.get(
      Uri.parse('https://api.twitch.tv/helix/users?login=$username'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Client-Id': clientId,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'].isNotEmpty) {
        return data['data'][0];
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to fetch Twitch user data: ${response.body}');
    }
  }
}
