// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../pages/user_nav_bar.dart';
import '../navbar.dart';

class PCBookingPage extends StatefulWidget {
  const PCBookingPage({Key? key}) : super(key: key);

  @override
  _PCBookingPageState createState() => _PCBookingPageState();
}

class _PCBookingPageState extends State<PCBookingPage> {
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
  List<int> timingsSelectedIndexesBackend = [];

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
  List<String> timeList = [];
  int selectedTimeSLot = 0;
  int seatCount = 12;
  int _selectedIndex = -1;
  FirebaseAuth auth = FirebaseAuth.instance;

  int totalPrice = 0;

  int noOfSeats = 0;

  DateTime selectedDate = DateTime.now();
  List<String> reservedTimes = [];

  void updateSum(int index) {
    int count = 0;
    for (var x in seats) {
      seats[count] = 0;
      count += 1;
    }
    count = 0;

    for (var x in isSelectedSlot) {
      if (x) {
        seats[count] += index + 1;
      }
      count += 1;
    }
    int sum = 0;
    for (var x in seats) {
      sum += x;
    }
    print(sum * 100);
    setState(() {
      totalPrice = sum * 100;
    });
  }

  Future<void> checkSlotAvailabilityAndBook() async {
    int totalPcnow = 0;
    List selectedTimes =
        timingsSelectedIndexes.map((index) => times[index]).toList();
    String selectedDatelocal = selectedDate.toIso8601String().substring(0, 10);
    print(selectedDate);
    print(selectedTimes);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('slots')
        .where('date', isEqualTo: selectedDatelocal)
        .where('times', arrayContainsAny: selectedTimes)
        .where('mode', isEqualTo: "PC")
        .get(GetOptions(source: Source.server));

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;

    bool slotsAvailable = true;

    if (docs.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
        int bookedPCs = doc['no_of_pc'];
        print('BookedPC ${bookedPCs}');
        totalPcnow += bookedPCs;
        if (totalPcnow >= 12) {
          slotsAvailable = false;
        }
      }
    }

    if (slotsAvailable) {
      int newNoOfSeats = noOfSeats + 1;
      if (totalPcnow + newNoOfSeats <= 12) {
        User? user = auth.currentUser;
        String? userId = user?.uid;
        // Store data in Firestore collection
        FirebaseFirestore.instance.collection('slots').add({
          'date': selectedDate.toIso8601String().substring(0, 10),
          'booking_date': selectedDate,
          'id': userId,
          'no_of_slots': reservedTimes.length,
          'no_of_pc': newNoOfSeats,
          'times': selectedTimes,
          'total_price': totalPrice,
          'mode': 'PC',
        }).then((value) async {
          Fluttertoast.showToast(
            msg: 'Slots booked successfully!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          print('Data stored successfully!');
          Navigator.pop(context);
        }).catchError((error) {
          Fluttertoast.showToast(
            msg: 'An error occurred while booking slots. Please try again.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          print('Error: $error');
        });
      } else {
        // Slots for the selected times are already booked
        int available = 12 - totalPcnow;
        Fluttertoast.showToast(
          msg: 'Only $available PC\'s available',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      // Slots for the selected times are already booked
      Fluttertoast.showToast(
        msg:
            'The selected slots are already booked. Please choose a different time slot.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

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
              fontSize: 27,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: FutureBuilder(builder: (context, snapshot) {
          return Column(
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
                                  child: Text(
                                    '${date.day}-${date.month}',
                                    style: GoogleFonts.bebasNeue(
                                      fontSize: 20,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ))
                            : Center(
                                child: Text(
                                '${date.day}-${date.month}',
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              )),
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
                          fontSize: 12,
                          color: Color.fromARGB(255, 255, 255, 255),
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
                              fontSize: 20,
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
                                        childAspectRatio: 3,
                                      ),
                                      itemBuilder: (context, index) {
                                        bool isSelected = timingsSelectedIndexes
                                            .contains(index);
                                        bool isSelect =
                                            timingsSelectedIndexesBackend
                                                .contains(index);
                                        return ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (isSelected) {
                                                timingsSelectedIndexes
                                                    .remove(index);
                                              } else {
                                                timingsSelectedIndexes
                                                    .add(index);
                                              }

                                              isSelectedSlot[index] =
                                                  !isSelectedSlot[index];
                                              if (isSelectedSlot[index]) {
                                                setState(() {
                                                  updateSum(noOfSeats);
                                                  print(seats);
                                                });
                                              } else {
                                                setState(() {
                                                  seats[index] = 0;
                                                  print(seats);
                                                  updateSum(noOfSeats);
                                                });
                                              }
                                            });
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              isSelected
                                                  ? Colors.yellow
                                                  : Colors.transparent,
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              isSelected
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            textStyle: MaterialStateProperty
                                                .all<TextStyle>(
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
                                          child: Text(
                                            ' ${times[index]}',
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 15),
                                          ),
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
                "How many seats do you want?",
                style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Container(
                  color: Color.fromARGB(255, 0, 0, 0),
                  height: 190,
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                          width: constraints.maxWidth,
                          height: 10,
                          child: GridView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 19,
                              childAspectRatio:
                                  1, // set the aspect ratio of each child widget
                            ),
                            itemBuilder: (context, index) {
                              return ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex =
                                        index; // Update the selected index
                                    int count = 0;

                                    noOfSeats = index;
                                    updateSum(index);
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    _selectedIndex == index
                                        ? Colors.yellow
                                        : Colors.transparent,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    _selectedIndex == index
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                    TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
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
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.bebasNeue(),
                                ),
                              );
                            },
                            itemCount: 12,
                          ));
                    },
                  )),
              ElevatedButton(
                onPressed: () {
                  // Storing data in Firestore collection
                  // Check slot availability and book
                  checkSlotAvailabilityAndBook();
                },
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(120, 5, 120, 5),
                    child: Column(
                      children: [
                        Text(
                          'Book Slots',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 27,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ),
                        ),
                        Text(
                          'Total Cost: \$$totalPrice',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 15,
                            color: Color.fromARGB(255, 3, 3, 3),
                          ),
                        ),
                      ],
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
          );
        }));
  }
}
