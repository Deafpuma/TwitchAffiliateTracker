import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print("🔄 Initializing Firebase...");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase Initialized!");
  } catch (e) {
    print("❌ Firebase Initialization Error: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("🔄 Building MyApp...");
    return MaterialApp(
      title: 'Twitch Affiliate Tracker',
      theme: ThemeData.dark(),
      home: AuthChecker(), // 🚀 New AuthChecker Widget to Debug Navigation
    );
  }
}

// 🚀 Debugging Widget to Track Authentication & Navigation
class AuthChecker extends StatefulWidget {
  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      checkAuthState();
    });
  }

  void checkAuthState() {
    User? user = _auth.currentUser;
    if (user != null) {
      print("✅ User detected: ${user.uid}, navigating to Home...");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print("❌ No user detected, navigating to Login...");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("🔄 AuthChecker Loaded");
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // Simple Loading Indicator
    );
  }
}
