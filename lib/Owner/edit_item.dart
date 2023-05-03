import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/User/feedback.dart';

class EditItem extends StatefulWidget {
  EditItem();

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Edit Profile',
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
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Remove Item',
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
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        print(_nameController.text);
                        print(_priceController.text);
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
