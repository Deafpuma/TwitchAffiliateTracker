import 'package:url_launcher/url_launcher.dart';

class TwitchService {
  final String clientId = "7ey7qjp0jpir4brr6uo6zb6ztmfn6z"; // Your Twitch Client ID
  final String redirectUri = "https://twitchstreamtracker-6e480.firebaseapp.com/__/auth/handler"; // Firebase Redirect URI

  Future<void> authenticate() async {
    final String authUrl = "https://id.twitch.tv/oauth2/authorize"
        "?client_id=$clientId"
        "&redirect_uri=$redirectUri"
        "&response_type=token"
        "&scope=user:read:email";

    // Open Twitch login in external browser
    if (await canLaunch(authUrl)) {
      await launch(authUrl, forceSafariVC: false, forceWebView: false);
    } else {
      print("❌ Could not launch Twitch login page.");
    }
  }
}
