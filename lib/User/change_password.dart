import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Change Password',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 26, 26, 26),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter your current password';
                  //   }
                  //   // Add custom validation logic here
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   _currentPassword = value;
                  // },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  decoration: InputDecoration(
                    labelText: 'New password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter a new password';
                  //   }
                  //   // Add custom validation logic here
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   _newPassword = value;
                  // },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmNewPasswordController,
                  obscureText: true,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Confirm new password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please confirm your new password';
                  //   }
                  //   if (value != _newPassword) {
                  //     return 'Passwords do not match';
                  //   }
                  //   // Add custom validation logic here
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   _confirmNewPassword = value;
                  // },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState.validate()) {
                    //   // Save the form fields
                    //   _formKey.currentState.save();
                    //   // Call your change password API or function here
                    // }
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
      ),
    );
  }
}
