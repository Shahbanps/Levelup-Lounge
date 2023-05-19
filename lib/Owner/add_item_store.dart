import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/User/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

import 'admin_store_dashboard.dart';

class AddItem extends StatefulWidget {
  AddItem();

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  PlatformFile? pickedFile;
  // UploadTask? task;
  File? file;
  late PlatformFile path;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    path = result.files.first;

    setState(() => pickedFile = path);
  }

  Future<void> upLoad() async {
    if (pickedFile != null) {
      // Upload the file to Firebase Storage
      storage.Reference storageRef =
          storage.FirebaseStorage.instance.ref().child('items/${path.name}');
      storage.UploadTask uploadTask =
          storageRef.putFile(File(pickedFile!.path!));
      storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Create a new document in Firestore and store the download URL
      firestore.FirebaseFirestore.instance.collection('items').add({
        'image_url': downloadUrl,
        'item_name': _nameController.text,
        'item_price': _priceController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Item',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        color: Color.fromARGB(255, 0, 0, 0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 26),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        decoration: InputDecoration(
                          labelText: 'New Name',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your item_name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _priceController,
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        decoration: InputDecoration(
                          labelText: 'New price',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your item_price';
                          }
                          return null;
                        },
                      ),
                      // if (pickedFile == null)
                      //   ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: Image(
                      //       image: AssetImage('assets/upload_image.gif'),
                      //     ),
                      //   ),
                      SizedBox(
                        height: 20,
                      ),
                      if (pickedFile != null)
                        SizedBox(
                          height: 300,
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
                          onTap: selectFile,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      if (pickedFile != null)
                        GestureDetector(
                          onTap: () {
                            selectFile();
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      SizedBox(height: 16.0),

                      ElevatedButton(
                        onPressed: () {
                          upLoad();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
