import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../User/dashboard.dart';
import '../User/feedback.dart';
import '../User/profile_screen.dart';
import '../User/store_dashboard.dart';
import 'admin_dashboard.dart';
import 'admin_profile.dart';
import 'admin_store_dashboard.dart';

class AdminNavbar extends StatefulWidget {
  const AdminNavbar({super.key});

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  int currentIndex = 0;

  List<String> texts = ['0', '1', '2', '3'];
  var Pages = [
    AdminDashboard(),
    AdminStorePage(),
    Feed_Back(),
    AdminProfileDashboard()
  ];
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
                text: 'Admin',
              ),
              GButton(icon: Icons.store_rounded, text: 'admin'),
              GButton(icon: Icons.feedback_rounded, text: 'Feedback'),
              GButton(icon: Icons.person_2_rounded, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
