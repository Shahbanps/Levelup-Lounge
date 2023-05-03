import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../booking_details.dart';
import 'change_password.dart';
import 'edit_profile.dart';

class ProfileDashboard extends StatefulWidget {
  const ProfileDashboard({Key? key}) : super(key: key);

  @override
  _ProfileDashboardState createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  String name = 'John Doe';
  String email = 'johndoe@gmail.com';
  String address = '123 Main Street';
  String paymentInfo = '**** **** **** 1234';
  String socialMediaHandle = '@johndoe';

  String profilePictureUrl = 'assets/0.jpg';

  PlatformFile? pickedFile;
  // UploadTask? task;
  File? file;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.first;

    setState(() => pickedFile = path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Profile',
            style: GoogleFonts.bebasNeue(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Stack(
              children: [
                // CircleAvatar(
                //   radius: 80.0,
                //   backgroundImage: pickedFile != null
                //       ?FileImage(pickedFile!.path!),
                //       : NetworkImage(profilePictureUrl),
                //   // ?NetworkImage(profilePictureUrl),
                // ),
                if (pickedFile == null)
                  CircleAvatar(
                    radius: 70.0,
                    backgroundImage: NetworkImage(profilePictureUrl),
                  ),
                if (pickedFile != null)
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(
                      File(pickedFile!.path!),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Add functionality to change the user's profile picture.
                        selectFile();
                      },
                      icon: Icon(Icons.camera_alt),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              name,
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              email,
              style: GoogleFonts.bebasNeue(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              address,
              style: GoogleFonts.bebasNeue(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        name: name,
                        email: email,
                        address: address,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
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
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 28, 28, 28),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()),
                      );
                    },
                    child: Text('Change Password',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Language Preference',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 28, 28, 28),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookingDetails(),
                      ));
                    },
                    child: Text('Booking Details',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 28, 28, 28),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('Logout',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 25, color: Colors.yellow)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
