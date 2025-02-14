import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/twitch_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TwitchService _twitchService = TwitchService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        print("✅ User detected: ${user.uid}, navigating to Home...");
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login to Twitch")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("🟢 Opening Twitch login page...");
            _twitchService.authenticate();
          },
          child: Text("Sign in with Twitch"),
        ),
      ),
    );
  }
}
