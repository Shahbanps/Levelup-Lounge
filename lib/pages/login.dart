import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:levelup/pages/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  Future signIn() async {
    // Close the keyboard
    FocusScope.of(context).unfocus();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (error) {
      setState(() {
        errorMessage = 'Invalid credentials';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.adjust,
                  color: Colors.yellow,
                  size: 100,
                ),
                SizedBox(
                  height: 75,
                ),
                Text(
                  "Hello Again champ",
                  style:
                      GoogleFonts.bebasNeue(color: Colors.white, fontSize: 56),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome back, you've been missed",
                  style: GoogleFonts.bebasNeue(
                      fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 35),
                      border:
                          Border.all(color: Color.fromARGB(255, 35, 35, 35)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: Color.fromARGB(255, 75, 75, 75)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 35, 35),
                      border:
                          Border.all(color: Color.fromARGB(255, 35, 35, 35)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: Color.fromARGB(255, 75, 75, 75)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      height: 40,
                      width: 175,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Login",
                              style: GoogleFonts.bebasNeue(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                        style: GoogleFonts.bebasNeue(
                            fontSize: 17,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (builder) => RegistrationPage()),
                        );
                      },
                      child: Text(" Register now",
                          style: GoogleFonts.bebasNeue(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  errorMessage,
                  style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
