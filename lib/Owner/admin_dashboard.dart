// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/Owner/pc/view_pc_bookings.dart';
import 'package:levelup/User/pc/pc_details_page.dart';

import '../User/carousel.dart';
import 'driving setup/view_driving_bookings.dart';
import 'squad room/view_squad_bookings.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Levelup Lounge',
            style: GoogleFonts.bebasNeue(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press here
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hello Shahban! Ready to Play.',
                style: GoogleFonts.bebasNeue(
                  fontSize: 56,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
                height: 225,
                child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    items: [
                      CarouselBox(
                          description:
                              'Escape reality and enter a world of adventure at our gaming center!',
                          url: "assets/0.jpg"),
                      CarouselBox(
                          description:
                              'Escape reality and enter a world of adventure at our gaming center!',
                          url: "assets/1.jpg"),
                      CarouselBox(
                          description:
                              'Escape reality and enter a world of adventure at our gaming center!',
                          url: "assets/2.jpg"),
                    ])),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 8.0, 0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Book your slots now!',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/3.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Color.fromARGB(255, 105, 105, 106),
                      border:
                          Border.all(color: Color.fromARGB(255, 20, 20, 20)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewPCBookingPage(),
                        ));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/4.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Color.fromARGB(255, 105, 105, 106),
                      border:
                          Border.all(color: Color.fromARGB(255, 20, 20, 20)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewSquadBookingPage(),
                        ));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/5.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Color.fromARGB(255, 105, 105, 106),
                      border:
                          Border.all(color: Color.fromARGB(255, 20, 20, 20)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewDrivingBookingPage(),
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(65, 10, 10, 10),
                  child: Center(
                    child: Text(
                      "PC",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(85, 10, 10, 10),
                  child: Center(
                    child: Text(
                      "Squad Room",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(47, 10, 10, 10),
                  child: Center(
                    child: Text(
                      "Driving Setup",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
