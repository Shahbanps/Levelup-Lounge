// ignore_for_file: implementation_imports, prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/User/dashboard.dart';

import 'login.dart';
import 'user_nav_bar.dart';

class RegistrationPage extends StatefulWidget {
  // final VoidCallback showLoginPage;
  RegistrationPage({
    super.key,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _phoneNumberController = TextEditingController();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      // Save user details to Firestore or any other database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'phoneNumber': _phoneNumberController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'type': "user",
      });

      // Navigate to the home screen or any other desired screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print(e);
      // Show error message to user
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // phone number
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register Up",
                    style: GoogleFonts.bebasNeue(fontSize: 46),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "Phone number",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 216, 216, 216),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 270,
                      height: 50,
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),

              //Name
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            12,
                          )),
                      width: 150,
                      height: 50,
                      child: TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "firstname",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 192, 191, 191))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            12,
                          )),
                      width: 110,
                      height: 50,
                      child: TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "lastname",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 192, 191, 191))),
                      ),
                    ),
                  )
                ],
              ),

              //email
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            12,
                          )),
                      width: 270,
                      height: 50,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  )
                ],
              ),
              //password
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(
                            12,
                          )),
                      width: 270,
                      height: 50,
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  )
                ],
              ),
              //register
              SizedBox(
                height: 50,
              ),
              Container(
                height: 40,
                width: 175,
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    GestureDetector(
                      onTap: signUp,
                      child: Center(
                        child: Text(
                          'Register',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 25,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // already member
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (builder) => LoginPage()));
                    },
                    child: Text(
                      " Signin now",
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
        )),
      ),
    );
  }
}
