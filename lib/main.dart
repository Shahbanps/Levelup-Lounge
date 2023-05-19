// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:levelup/Owner/add_item_store.dart';
import 'package:levelup/pages/login.dart';
import 'package:levelup/pages/registration.dart';

import 'Owner/admin_store_dashboard.dart';
import 'Owner/admin_edit_item.dart';
import 'Owner/pc/view_pc_bookings.dart';

import 'User/admin_pc_booking.dart';
import 'User/dashboard.dart';
import 'User/feedback.dart';
import 'User/profile_screen.dart';
import 'User/purchase_details.dart';
import 'User/store_dashboard.dart';
import 'User/booking_details.dart';
import 'auth/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
    );
  }
}
