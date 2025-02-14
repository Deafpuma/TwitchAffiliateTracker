import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection("users").doc(user!.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data() as Map<String, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: user == null
          ? Center(child: Text("Not logged in"))
          : userData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userData!["profile_picture"] ?? ""),
            radius: 50,
          ),
          SizedBox(height: 10),
          Text("Username: ${userData!["display_name"]}"),
          SizedBox(height: 10),
          Text("Email: ${userData!["email"]}"),
          SizedBox(height: 10),
          Text("Subscription: ${userData!["subscription"]}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
