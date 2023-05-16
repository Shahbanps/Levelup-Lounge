import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:levelup/User/dashboard.dart';
import 'package:levelup/pages/login.dart';

import '../Owner/admin_navbar.dart';
import '../pages/user_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (userSnapshot.hasData) {
                  final userData = userSnapshot.data!.data();
                  if (userData is Map<String, dynamic>) {
                    // Add null check before type cast
                    final userType = userData['type'] as String?;
                    if (userType == 'owner') {
                      return AdminNavbar();
                    } else {
                      return UserNavBar();
                    }
                  }
                }
                return LoginPage(); // Handle the case when user data is null or not of the expected type
              },
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
