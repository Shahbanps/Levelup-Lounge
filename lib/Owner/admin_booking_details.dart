import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminBookingDetails(),
    );
  }
}

class AdminBookingDetails extends StatefulWidget {
  @override
  Admin_BookingDetailsState createState() => Admin_BookingDetailsState();
}

class Admin_BookingDetailsState extends State<AdminBookingDetails> {
  String _selectedDateFilter = "Today";
  List<Map<String, dynamic>> _bookingData = [
    {
      "time": "10:00 AM - 12:00 PM",
      "slotsBooked": 4,
      "type": "PC",
      "date": "2023-05-04"
    },
    {
      "time": "02:00 PM - 04:00 PM",
      "slotsBooked": 2,
      "type": "Squad Room",
      "date": "2023-05-03"
    },
    {
      "time": "05:00 PM - 06:00 PM",
      "slotsBooked": 1,
      "type": "Driving Setup",
      "date": "2023-05-02"
    },
    {
      "time": "05:00 PM - 06:00 PM",
      "slotsBooked": 1,
      "type": "Driving Setup",
      "date": "2023-05-02"
    },
    {
      "time": "05:00 PM - 06:00 PM",
      "slotsBooked": 1,
      "type": "Driving Setup",
      "date": "2023-05-02"
    },
    {
      "time": "05:00 PM - 06:00 PM",
      "slotsBooked": 3,
      "type": "Driving Setup",
      "date": "2023-05-02"
    },
    {
      "time": "05:00 PM - 06:00 PM",
      "slotsBooked": 2,
      "type": "Driving Setup",
      "date": "2023-05-02"
    },
  ];

  List<Map<String, dynamic>> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filterData();
  }

  void _filterData() {
    _filteredData.clear();
    final now = DateTime.now();
    final todayDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final yesterdayDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${(now.day - 1).toString().padLeft(2, '0')}";
    final thisMonth = "${now.year}-${now.month.toString().padLeft(2, '0')}-";
    for (var booking in _bookingData) {
      if (_selectedDateFilter == "Today" && booking['date'] == todayDate) {
        _filteredData.add(booking);
      } else if (_selectedDateFilter == "Yesterday" &&
          booking['date'] == yesterdayDate) {
        _filteredData.add(booking);
      } else if (_selectedDateFilter == "This Month" &&
          booking['date'].startsWith(thisMonth)) {
        _filteredData.add(booking);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Booking Details',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.yellow,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButton(
                value: _selectedDateFilter,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "Today",
                      style: GoogleFonts.bebasNeue(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    value: "Today",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Yesterday",
                      style: GoogleFonts.bebasNeue(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    value: "Yesterday",
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "This Month",
                      style: GoogleFonts.bebasNeue(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    value: "This Month",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDateFilter = value ?? "";
                    _filterData();
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white,
              height: 0,
              thickness: 0.3,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  final booking = _filteredData[index];
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time: ${booking['time']}",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Slots Booked: ${booking['slotsBooked']}",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Type: ${booking['type']}",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
