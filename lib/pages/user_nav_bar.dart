import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../User/dashboard.dart';
import '../User/feedback.dart';
import '../User/profile_screen.dart';
import '../User/store_dashboard.dart';

class UserNavBar extends StatefulWidget {
  const UserNavBar({super.key});

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
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
