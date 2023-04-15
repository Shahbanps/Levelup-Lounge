// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:levelup/booking_page.dart';
import 'package:levelup/details_page.dart';
import 'package:levelup/login.dart';
import 'package:levelup/model/cart_model.dart';
import 'package:levelup/navbar.dart';
import 'package:levelup/registration.dart';
import 'package:levelup/store_dashboard.dart';
import 'package:levelup/timings.dart';
import 'package:provider/provider.dart';
import 'dashboard.dart';
import 'package:levelup/feedback.dart';
import 'package:levelup/profile_screen.dart';

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
    return ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: Scaffold(
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
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Color.fromARGB(255, 43, 43, 43),
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
        ));
  }
}
