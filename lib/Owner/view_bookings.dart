import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewPCBookingPage extends StatefulWidget {
  ViewPCBookingPage({super.key});

  @override
  State<ViewPCBookingPage> createState() => _ViePCwBookingPageState();
}

class _ViePCwBookingPageState extends State<ViewPCBookingPage> {
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
                fontSize: 25, color: Color.fromARGB(255, 255, 255, 255)),
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
                                    child: Text(
                                      '${date.day}-${date.month}',
                                      style: GoogleFonts.bebasNeue(
                                        fontSize: 20,
                                        color: isSelected
                                            ? Color.fromARGB(255, 255, 255, 255)
                                            : Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  )))
                          : Center(
                              child: Text(
                              '${date.day}-${date.month}',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 15,
                                color: isSelected
                                    ? Color.fromARGB(255, 255, 255, 255)
                                    : Color.fromARGB(255, 0, 0, 0),
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
                      "View all the booked users.",
                      style: GoogleFonts.bebasNeue(
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 255, 255)),
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
                              color: Color.fromARGB(255, 255, 255, 255)),
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
                                        onPressed: () async {
                                          setState(() {
                                            timingsSelectedIndexes
                                                .clear(); // clear all selected indexes
                                            timingsSelectedIndexes.add(
                                                index); // add the clicked index
                                          });

                                          String formattedDate = selectedDate
                                              .toString()
                                              .substring(0,
                                                  10); // Convert DateTime to "yyyy-MM-dd" format
                                          final selectedSlotTime = times[index];

                                          print(
                                              'Selected Date: $formattedDate');
                                          print(
                                              'Selected Slot Time: $selectedSlotTime');

                                          final QuerySnapshot<
                                                  Map<String, dynamic>>
                                              querySnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('slots')
                                                  .where('date',
                                                      isEqualTo: formattedDate)
                                                  .where('times',
                                                      arrayContains:
                                                          selectedSlotTime)
                                                  .get();

                                          print(
                                              'Query Snapshot Length: ${querySnapshot.docs.length}');

                                          if (querySnapshot.docs.isNotEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Booked Slots',
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                            fontSize: 25,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                  ),
                                                  content: Container(
                                                    width: double.maxFinite,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: querySnapshot
                                                          .docs.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final slotData =
                                                            querySnapshot
                                                                .docs[index]
                                                                .data();

                                                        final id =
                                                            slotData['id']
                                                                as String?;
                                                        final mode =
                                                            slotData['mode']
                                                                as String?;

                                                        return FutureBuilder<
                                                            DocumentSnapshot>(
                                                          future:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(id)
                                                                  .get(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      DocumentSnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              // While waiting for the document to be fetched, show a loading indicator
                                                              return CircularProgressIndicator();
                                                            }
                                                            if (snapshot
                                                                .hasError) {
                                                              // Handle any potential error
                                                              return Text(
                                                                  'Error: ${snapshot.error}');
                                                            }
                                                            if (!snapshot
                                                                    .hasData ||
                                                                snapshot.data ==
                                                                    null) {
                                                              // If the document doesn't exist or there's no data, display 'N/A' for the name
                                                              return Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Name: N/A',
                                                                    style: GoogleFonts.bebasNeue(
                                                                        fontSize:
                                                                            18,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                                  ),
                                                                  Text(
                                                                    'Type: $mode',
                                                                    style: GoogleFonts.bebasNeue(
                                                                        fontSize:
                                                                            18,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0)),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Divider(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    height: 0,
                                                                    thickness:
                                                                        0.3,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                ],
                                                              );
                                                            }

                                                            final userData =
                                                                snapshot.data!
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>?;
                                                            final firstName =
                                                                userData?[
                                                                        'firstName']
                                                                    as String?;

                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Name: ${firstName ?? 'N/A'}',
                                                                  style: GoogleFonts.bebasNeue(
                                                                      fontSize:
                                                                          18,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0)),
                                                                ),
                                                                Text(
                                                                  'Type: $mode',
                                                                  style: GoogleFonts.bebasNeue(
                                                                      fontSize:
                                                                          18,
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0)),
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                                Divider(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  height: 0,
                                                                  thickness:
                                                                      0.3,
                                                                ),
                                                                SizedBox(
                                                                    height: 10),
                                                              ],
                                                            );
                                                          },
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
                                                                fontSize: 25,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0)),
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
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  title: Text(
                                                    'No Booked Slots',
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                            fontSize: 20,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                  ),
                                                  content: Text(
                                                    'There are no slots booked for the selected time.',
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                            fontSize: 18,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0)),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'Close',
                                                        style: GoogleFonts
                                                            .bebasNeue(
                                                                fontSize: 20,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0)),
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
                                          }
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
                                        child: Text(
                                          ' ${times[index]}',
                                          style: GoogleFonts.bebasNeue(
                                            fontSize: 15,
                                            color: isSelected
                                                ? Color.fromARGB(255, 0, 0, 0)
                                                : Color.fromARGB(
                                                    255, 255, 255, 255),
                                          ),
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
          ],
        ));
  }
}
