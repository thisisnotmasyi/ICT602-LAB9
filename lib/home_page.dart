import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _revokeGoogleTokens() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  }

  Future<void> _logout(BuildContext context) async {
    try {
      // Sign out locally within your app
      await FirebaseAuth.instance.signOut();

      // Revoke Google tokens
      await _revokeGoogleTokens();

      // Navigate back to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      print('Logout error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Container(
          color: Color(0xFFF4FBFE), // Background color
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Perform logout
                  await _logout(context);
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
