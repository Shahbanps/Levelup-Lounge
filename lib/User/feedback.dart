// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class Feed_Back extends StatefulWidget {
  const Feed_Back({super.key});

  @override
  State<Feed_Back> createState() => _Feed_BackState();
}

class _Feed_BackState extends State<Feed_Back> {
  User? currentUser;

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<bool> buttonStates = [false, false, false, false, false];
  List<String> feedbackTypes = [
    "Login trouble",
    "Slots booking related",
    "Personal profile",
    "Other issues",
    "Suggestions",
  ];
  PlatformFile? pickedFile;
  // UploadTask? task;
  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.first;

    setState(() => pickedFile = path);
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
            controller: _descriptionController, // add controller
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
                        child: Row(
                          children: [
                            if (pickedFile != null)
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(
                                      pickedFile!.path!,
                                    ),
                                  ),
                                ),
                              ),
                            if (pickedFile == null)
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            if (pickedFile != null)
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                          ],
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

  buildCheckItem(String title, int index, List<bool> buttonStates,
      Function(int) onItemSelected) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: GestureDetector(
          onTap: () {
            // Set the selected state of this button to true
            onItemSelected(index);
          },
          child: Row(
            children: <Widget>[
              Icon(
                buttonStates[index]
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: GoogleFonts.bebasNeue(
                  fontSize: 15,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onButtonSelected(int selectedIndex) {
    setState(() {
      for (int i = 0; i < buttonStates.length; i++) {
        buttonStates[i] = i == selectedIndex;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    setState(() {
      currentUser = user;
    });
  }

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
      body: Container(
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
            buildCheckItem("Login trouble", 0, buttonStates, onButtonSelected),
            buildCheckItem(
                "Slots booking related", 1, buttonStates, onButtonSelected),
            buildCheckItem(
                "Personal profile", 2, buttonStates, onButtonSelected),
            buildCheckItem("Other issues.", 3, buttonStates, onButtonSelected),
            buildCheckItem("Suggestions", 4, buttonStates, onButtonSelected),
            SizedBox(
              height: 20,
            ),
            buildFeedbackForm(),
            SizedBox(
              height: 20,
            ),
            buildNuberField(_phoneNumberController),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (currentUser != null) {
                  // Get the current date and time
                  DateTime now = DateTime.now();

                  // Prepare the feedback data to be stored in Firestore
                  Map<String, dynamic> feedbackData = {
                    'feedback_type': feedbackTypes[buttonStates.indexOf(true)],
                    'description': _descriptionController.text,
                    'screenshot_url':
                        pickedFile != null ? pickedFile!.path! : null,
                    'phone_number': _phoneNumberController.text,
                    'date': now,
                    'user_id': currentUser
                        ?.uid, // Add the user ID to the feedback data
                  };

                  FirebaseFirestore.instance
                      .collection('feedback')
                      .add(feedbackData)
                      .then((value) {
                    // Feedback stored successfully
                    print('Feedback stored in Firestore');
                    // Show an alert dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: Text(
                            'Success',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 15,
                            ),
                          ),
                          content: Text(
                            'Feedback submitted successfully.',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 15,
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 15,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors
                                        .black), // Set the desired color here
                                // Add other customizations if needed
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    // Clear the text controllers and reset the variables
                    _phoneNumberController.clear();
                    _descriptionController.clear();
                    pickedFile = null;
                    setState(() {
                      buttonStates = List<bool>.filled(5, false);
                    });
                  }).catchError((error) {
                    // Error occurred while storing feedback
                    print('Error storing feedback: $error');
                    // TODO: Show an error message to the user
                  });
                } else {
                  // User not signed in
                  print('User not signed in');
                  // TODO: Show an error message to the user
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(120, 5, 160, 5),
                child: Text(
                  '      Submit',
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
        ),
      ),
    );
  }
}

buildNuberField(TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 42, 42, 42),
        borderRadius: BorderRadius.circular(10)),
    child: TextField(
      controller: controller, // added controller
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
