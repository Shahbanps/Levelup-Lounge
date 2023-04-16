// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/circles.dart';
import 'package:levelup/feedback.dart';
import 'package:levelup/timings.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final List dates = [
    'date 1',
    'date 2',
    'date 3',
    'date 4',
    'date 5',
    'date 6',
    'date 7',
    'date 8',
    'date 9',
    'date 10',
  ];

  String dropdownvalue = '1';

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
          title: Text(
            'PC Booking',
            style: GoogleFonts.bebasNeue(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 80),
            Container(
              height: 70,
              child: ListView.builder(
                  itemCount: dates.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Mycircle(
                      child: dates[index],
                    );
                  }),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 143, 143, 143), //New
                      blurRadius: 0.2,
                      offset: Offset(0, 0.2))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 3),
                    child: Text(
                      "Individual  .  PC's  .  100₹  .  per slot / per person",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 3),
                    child: Text(
                      "Seats needed ",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      border:
                          Border.all(color: Color.fromARGB(255, 20, 20, 20)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          // ignore: sort_child_properties_last
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("1",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '1',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("2",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '2',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("3",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '3',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("4",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '4',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("5",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '5',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("6",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '6',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("7",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '7',
                        ),
                        DropdownMenuItem(
                          // ignore: sort_child_properties_last
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("8",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                          value: '8',
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              height: 0,
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 28, 28),
                  border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 500,
                height: 350,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Available slot timings",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Container(
                            height: 300,
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Container(
                                  width: constraints.maxWidth,
                                  height: 10,
                                  child: GridView.builder(
                                    padding: EdgeInsets.only(top: 20),
                                    // physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 30,
                                      childAspectRatio:
                                          3, // set the aspect ratio of each child widget
                                    ),
                                    itemBuilder: (context, index) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          // action to perform when button is pressed
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          textStyle: MaterialStateProperty.all<
                                              TextStyle>(
                                            TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors
                                                    .yellow, // set the border color here
                                                width:
                                                    0.5, // set the width of the border
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                        child: Text('Button $index'),
                                      );
                                    },
                                    itemCount: 12,
                                  ),
                                );
                              },
                            )),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Select where you wanna sit.",
              style: GoogleFonts.bebasNeue(
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Container(
                color: Color.fromARGB(255, 0, 0, 0),
                height: 190,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      width: constraints.maxWidth,
                      height: 10,
                      child: GridView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 19,
                          childAspectRatio:
                              1, // set the aspect ratio of each child widget
                        ),
                        itemBuilder: (context, index) {
                          return ElevatedButton(
                            onPressed: () {
                              // action to perform when button is pressed
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors
                                        .yellow, // set the border color here
                                    width: 0.5, // set the width of the border
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            child: Text('$index'),
                          );
                        },
                        itemCount: 12,
                      ),
                    );
                  },
                )),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Feed_Back()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(120, 5, 120, 5),
                child: Text(
                  'Book Slots',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 25,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
