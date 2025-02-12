import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login to Twitch Affiliate Tracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var user = await _authService.signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text("Sign in with Google"),
            ),
            ElevatedButton(
              onPressed: () async {
                var user = await _authService.signInWithTwitch();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text("Sign in with Twitch"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/email_login');
              },
              child: Text("Sign in with Email"),
            ),
          ],
        ),
      ),
    );
  }
}
