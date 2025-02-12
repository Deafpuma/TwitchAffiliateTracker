import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSignUp = false; // Toggles between Sign In and Sign Up

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isSignUp ? "Sign Up" : "Sign In with Email")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter email and password")),
                  );
                  return;
                }

                try {
                  UserCredential userCredential;
                  if (isSignUp) {
                    userCredential = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                  } else {
                    userCredential = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                  }

                  if (userCredential.user != null) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              child: Text(isSignUp ? "Sign Up" : "Sign In"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isSignUp = !isSignUp; // Toggle Sign Up / Sign In
                });
              },
              child: Text(isSignUp
                  ? "Already have an account? Sign In"
                  : "Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
