// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewDrivingBookingPage extends StatefulWidget {
  ViewDrivingBookingPage({super.key});

  @override
  State<ViewDrivingBookingPage> createState() => _ViewDrivingBookingPageState();
}

class _ViewDrivingBookingPageState extends State<ViewDrivingBookingPage> {
  final List times = [
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00 - 17:00',
    '17:00 - 18:00',
    '18:00 - 19:00',
    '19:00 - 20:00',
    '20:00 - 21:00',
  ];
  List<int> timingsSelectedIndexes = [];

  List<int> seats = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  List<bool> isSelectedSlot = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  int selectedTimeSLot = 0;

  int _selectedIndex = -1;

  int totalPrice = 0;

  int noOfSeats = 0;

  DateTime selectedDate = DateTime.now();

  // void updateSum(int index) {
  //   int count = 0;
  //   for (var x in seats) {
  //     seats[count] = 0;
  //     count += 1;
  //   }
  //   count = 0;

  //   for (var x in isSelectedSlot) {
  //     if (x) {
  //       seats[count] += index + 1;
  //     }
  //     count += 1;
  //   }
  //   int sum = 0;
  //   for (var x in seats) {
  //     sum += x;
  //   }
  //   print(sum * 100);
  //   setState(() {
  //     totalPrice = sum * 100;
  //   });
  // }

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
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // Calculate the date for this index
                  final date = DateTime.now().add(Duration(days: index));

                  // Determine whether this date is the currently selected date
                  final isSelected = date.year == selectedDate.year &&
                      date.month == selectedDate.month &&
                      date.day == selectedDate.day;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                          // shape: BoxShape.rectangle,
                          color: Color.fromARGB(255, 250, 227, 54)),
                      child: isSelected
                          ? Center(
                              child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 42, 42, 42)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 20),
                                child: Text('${date.day}-${date.month}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                              ),
                            ))
                          : Center(
                              child: Text('${date.day}-${date.month}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ))),
                    ),
                  );
                },
              ),
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
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 30,
                                      childAspectRatio: 3,
                                    ),
                                    itemBuilder: (context, index) {
                                      bool isSelected = timingsSelectedIndexes
                                          .contains(index);
                                      return ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            timingsSelectedIndexes
                                                .clear(); // clear all selected indexes
                                            timingsSelectedIndexes.add(index);
                                            // add the clicked index
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Booked Slots',
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                                  content: Container(
                                                    width: double.maxFinite,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: 3,
                                                      // bookedSlots.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Name: ',
                                                              style: GoogleFonts
                                                                  .bebasNeue(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                              ),
                                                            ),
                                                            // ${bookedSlots[index].name}
                                                            Text(
                                                              'Number of slots: ',
                                                              style: GoogleFonts
                                                                  .bebasNeue(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                              ),
                                                            ),
                                                            // ${bookedSlots[index].slots}
                                                            SizedBox(
                                                                height: 10),
                                                            Divider(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              height: 0,
                                                              thickness: 0.3,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'Close',
                                                        style: GoogleFonts
                                                            .bebasNeue(
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          });
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            isSelected
                                                ? Colors.yellow
                                                : Colors.transparent,
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                            isSelected
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          textStyle: MaterialStateProperty.all<
                                              TextStyle>(
                                            TextStyle(
                                              fontSize: 12,
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
                                                color: Colors.yellow,
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                        child: Text(' ${times[index]}'),
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
            // Text(
            //   "How many slot do you want?",
            //   style: GoogleFonts.bebasNeue(
            //     fontSize: 16,
            //     color: Color.fromARGB(255, 255, 255, 255),
            //   ),
            // ),
            // Container(
            //     color: Color.fromARGB(255, 0, 0, 0),
            //     height: 190,
            //     padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            //     child: LayoutBuilder(
            //       builder: (BuildContext context, BoxConstraints constraints) {
            //         return Container(
            //             width: constraints.maxWidth,
            //             height: 10,
            //             child: GridView.builder(
            //               // physics: NeverScrollableScrollPhysics(),
            //               gridDelegate:
            //                   SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 6,
            //                 crossAxisSpacing: 30,
            //                 mainAxisSpacing: 19,
            //                 childAspectRatio:
            //                     1, // set the aspect ratio of each child widget
            //               ),
            //               itemBuilder: (context, index) {
            //                 return ElevatedButton(
            //                   onPressed: () {
            //                     setState(() {
            //                       _selectedIndex =
            //                           index; // Update the selected index
            //                       int count = 0;

            //                       noOfSeats = index;
            //                       updateSum(index);
            //                     });
            //                   },
            //                   style: ButtonStyle(
            //                     backgroundColor:
            //                         MaterialStateProperty.all<Color>(
            //                       _selectedIndex == index
            //                           ? Colors.yellow
            //                           : Colors.transparent,
            //                     ),
            //                     foregroundColor:
            //                         MaterialStateProperty.all<Color>(
            //                       _selectedIndex == index
            //                           ? Colors.black
            //                           : Colors.white,
            //                     ),
            //                     textStyle: MaterialStateProperty.all<TextStyle>(
            //                       TextStyle(
            //                         fontSize: 12,
            //                       ),
            //                     ),
            //                     padding: MaterialStateProperty.all<
            //                         EdgeInsetsGeometry>(
            //                       EdgeInsets.symmetric(
            //                           horizontal: 5, vertical: 5),
            //                     ),
            //                     shape: MaterialStateProperty.all<
            //                         RoundedRectangleBorder>(
            //                       RoundedRectangleBorder(
            //                         side: BorderSide(
            //                           color: Colors
            //                               .yellow, // set the border color here
            //                           width: 0.5, // set the width of the border
            //                         ),
            //                         borderRadius: BorderRadius.circular(4),
            //                       ),
            //                     ),
            //                   ),
            //                   child: Text('${index + 1}'),
            //                 );
            //               },
            //               itemCount: 12,
            //             ));
            //       },
            //     )),
            // ElevatedButton(
            //   onPressed: () {
            //     // Your button press logic here
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(120, 5, 120, 5),
            //     child: Column(
            //       children: [
            //         Text(
            //           'Book Slots',
            //           style: GoogleFonts.bebasNeue(
            //             fontSize: 25,
            //             color: Color.fromARGB(255, 0, 0, 0),
            //           ),
            //         ),
            //         Text(
            //           'Total Cost: \$$totalPrice',
            //           style: GoogleFonts.bebasNeue(
            //             fontSize: 18,
            //             color: Color.fromARGB(255, 0, 0, 0),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all<Color>(Colors.yellow),
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
