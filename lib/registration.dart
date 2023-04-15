// ignore_for_file: implementation_imports, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
                    Text(
                      "Register",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
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
