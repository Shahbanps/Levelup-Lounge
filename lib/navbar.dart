// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    var index;
    return Scaffold(
        bottomNavigationBar: Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
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
    ));
  }
}
