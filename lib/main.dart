import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'config/app_config.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/email_login.dart';  // ✅ Make sure this file exists
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitch Affiliate Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: AuthWrapper(),
      routes: {
        '/email_login': (context) => EmailLoginScreen(), // ✅ Ensure this exists
        '/home': (context) => HomeScreen(),  // ✅ Ensure Twitch login can navigate here
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        }
        if (snapshot.hasData) {
          return HomeScreen(); // Redirects to home if logged in
        } else {
          return LoginScreen(); // Redirects to existing login_screen.dart
        }
      },
    );
  }
}
