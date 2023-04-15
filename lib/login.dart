// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/dashboard.dart';
import 'package:levelup/main.dart';
import 'package:levelup/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hello again
                Icon(
                  Icons.adjust,
                  size: 100,
                ),
                SizedBox(
                  height: 75,
                ),
                Text(
                  "Hello Again champ",
                  style: GoogleFonts.bebasNeue(fontSize: 56),
                ),
                SizedBox(height: 10),
                Text("Welcome back, you've been missed",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                SizedBox(height: 50),
                //emailtextfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 198, 198, 198),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'email',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 192, 191, 191))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 196, 196, 196),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 192, 191, 191))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 40,
                    width: 175,
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                //new user

                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ));
                      },
                      child: Text(
                        " Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
