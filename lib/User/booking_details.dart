import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingDetails extends StatefulWidget {
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<DocumentSnapshot> _slots = [];
  String _selectedFilter = 'Today';
  String _currentUserName = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserName();
    _fetchSlots();
  }

  void _fetchCurrentUserName() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();

      String firstName = userSnapshot['firstName'];
      String lastName = userSnapshot['lastName'];

      setState(() {
        _currentUserName = '$firstName $lastName';
      });
    }
  }

  void _fetchSlots() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('slots')
        .orderBy('booking_date', descending: true)
        .get();

    setState(() {
      _slots = querySnapshot.docs;
    });
  }

  List<DocumentSnapshot> _getFilteredSlots() {
    DateTime now = DateTime.now();
    if (_selectedFilter == 'Today') {
      return _slots
          .where((slot) =>
              slot['id'] == _auth.currentUser?.uid &&
              slot['booking_date'].toDate().day == now.day &&
              slot['booking_date'].toDate().month == now.month &&
              slot['booking_date'].toDate().year == now.year)
          .toList();
    } else if (_selectedFilter == 'Yesterday') {
      DateTime yesterday = now.subtract(Duration(days: 1));
      return _slots
          .where((slot) =>
              slot['id'] == _auth.currentUser?.uid &&
              slot['booking_date'].toDate().day == yesterday.day &&
              slot['booking_date'].toDate().month == yesterday.month &&
              slot['booking_date'].toDate().year == yesterday.year)
          .toList();
    } else if (_selectedFilter == 'This Month') {
      return _slots
          .where((slot) =>
              slot['id'] == _auth.currentUser?.uid &&
              slot['booking_date'].toDate().month == now.month &&
              slot['booking_date'].toDate().year == now.year)
          .toList();
    } else {
      return _slots
          .where((slot) => slot['id'] == _auth.currentUser?.uid)
          .toList();
    }
  }

  Widget _buildSlotItem(DocumentSnapshot slot) {
    return ListTile(
      title: Text(
        'Items: ${slot['times'].join(', ')}',
        style: GoogleFonts.bebasNeue(
          fontSize: 20,
          color: Color.fromARGB(255, 224, 224, 224),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            'Total Price: ${slot['total_price']}',
            style: GoogleFonts.bebasNeue(
              fontSize: 18,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
          SizedBox(height: 5),
          Text(
            slot['booking_date'].toDate().toString(),
            style: GoogleFonts.bebasNeue(
              fontSize: 10,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
          Text(
            'Mode: ${slot['mode']}',
            style: GoogleFonts.bebasNeue(
              fontSize: 10,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
          Text(
            'No of PC: ${slot['no_of_pc']}',
            style: GoogleFonts.bebasNeue(
              fontSize: 10,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> filteredSlots = _getFilteredSlots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 100,
        title: Text(
          'Purchase Details',
          style: GoogleFonts.bebasNeue(
            fontSize: 20,
            color: Color.fromARGB(255, 224, 224, 224),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: Color.fromARGB(255, 25, 25, 25),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 44, 44, 44),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 3),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  items: ['Today', 'Yesterday', 'This Month']
                      .map((filter) => DropdownMenuItem<String>(
                            value: filter,
                            child: Text(
                              filter,
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                    });
                  },
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  dropdownColor: Colors.yellow,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: filteredSlots.isEmpty
                    ? Center(
                        child: Text(
                          'No purchases',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 35,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredSlots.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildSlotItem(filteredSlots[index]),
                              if (index < filteredSlots.length - 1)
                                Divider(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  height: 0,
                                  thickness: 0.3,
                                ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
