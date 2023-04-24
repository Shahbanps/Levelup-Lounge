// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/pc_booking_page.dart';
import 'package:levelup/dashboard.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/PC.png"), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
              Color.fromARGB(255, 0, 0, 0).withOpacity(1),
            ], stops: [
              0.0,
              1
            ], begin: Alignment.topCenter),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 500.0,
                  margin: EdgeInsets.only(top: 23.80),
                  padding: EdgeInsets.fromLTRB(16.0, 25, 16, 16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 16, 16, 16).withOpacity(0.278),
                    Color.fromARGB(255, 0, 0, 0).withOpacity(0.26)
                  ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "PC",
                        style: GoogleFonts.bebasNeue(
                          fontSize: 90,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "A Privileged Gaming Corner",
                        style: GoogleFonts.bebasNeue(
                          fontSize: 15,
                          color: Color.fromARGB(255, 224, 224, 224),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 250.0),
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PCBookingPage()),
                          );
                        },
                        // ignore: sort_child_properties_last
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Book slots",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 27,
                                color: Color.fromARGB(255, 3, 3, 3),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.bookmark_add_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PCBookingPage(),
                                ));
                              },
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Color.fromARGB(255, 250, 227, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 400.0,
                  margin: EdgeInsets.only(top: 0.0),
                  padding: EdgeInsets.fromLTRB(11, 10, 0, 10),
                  child: Text(
                    "Experience an immersive and\nengaging gaming experience at\nour PC gaming center with powerful hardware, a variety of games, and a friendly community. Connect with others and enjoy the ultimate gaming experience",
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
