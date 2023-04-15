// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/booking_page.dart';

class Feed_Back extends StatelessWidget {
  const Feed_Back({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 100,
        title: Center(
          child: Text(
            '   Feedback',
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
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 70, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Please select the type of feedback.',
              style: GoogleFonts.bebasNeue(
                fontSize: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 25),
            buildCheckItem("Login trouble"),
            buildCheckItem("Slots booking related"),
            buildCheckItem("Personal profile"),
            buildCheckItem("Other issues."),
            buildCheckItem("Suggestions"),
            SizedBox(
              height: 20,
            ),
            buildFeedbackForm(),
            SizedBox(
              height: 20,
            ),
            buildNuberField(),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingPage()),
                        );
                      },
                      // ignore: sort_child_properties_last
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Submit",
                            style: GoogleFonts.bebasNeue(
                              fontSize: 27,
                              color: Color.fromARGB(255, 3, 3, 3),
                            ),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

buildNuberField() {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 42, 42, 42),
        borderRadius: BorderRadius.circular(10)),
    child: TextField(
      style: GoogleFonts.bebasNeue(
        textStyle: TextStyle(
          fontSize: 20,
          color: Color(0xffe5e5e5),
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: Colors.yellow),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "+91",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        hintText: "Phone Number",
        hintStyle: GoogleFonts.bebasNeue(
          textStyle: TextStyle(
            fontSize: 20,
            color: Color(0xffe5e5e5),
          ),
        ),
        border: OutlineInputBorder(),
      ),
    ),
  );
}

buildFeedbackForm() {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 42, 42, 42),
        borderRadius: BorderRadius.circular(10)),
    height: 200,
    child: Stack(
      children: <Widget>[
        TextField(
          style: GoogleFonts.bebasNeue(
            textStyle: TextStyle(
              fontSize: 15,
              color: Color(0xffe5e5e5),
            ),
          ),
          maxLines: 10,
          decoration: InputDecoration(
            hintText: "Please breifly describe the issue.",
            hintStyle: GoogleFonts.bebasNeue(
              textStyle: TextStyle(
                fontSize: 15,
                color: Color(0xffe5e5e5),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.yellow, // Change border color here
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 1.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ))),
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Upload Screenshot (optional)",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 27,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

buildCheckItem(title) {
  return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.yellow,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: GoogleFonts.bebasNeue(
              fontSize: 15,
              color: Colors.yellow,
            ),
          ),
        ],
      ));
}
