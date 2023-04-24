// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:levelup/login.dart';
import 'package:levelup/registration.dart';

import 'User/dashboard.dart';
import 'User/feedback.dart';
import 'User/profile_screen.dart';
import 'User/store_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<String> texts = ['0', '1', '2', '3'];
  var Pages = [Dashboard(), StorePage(), Feed_Back(), ProfileDashboard()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            onTabChange: (i) {
              setState(() {
                currentIndex = i;
              });
            },
            backgroundColor: Colors.black,
            color: Color.fromARGB(255, 255, 255, 255),
            activeColor: Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: Color.fromARGB(255, 31, 31, 31),
            padding: EdgeInsets.all(16),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                text: 'Home',
              ),
              GButton(icon: Icons.store_rounded, text: 'Store'),
              GButton(icon: Icons.feedback_rounded, text: 'Feedback'),
              GButton(icon: Icons.person_2_rounded, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
