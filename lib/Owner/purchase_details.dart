import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PurchseDetails(),
    );
  }
}

class PurchseDetails extends StatefulWidget {
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<PurchseDetails> {
  String _selectedDateFilter = "Today";
  List<Map<String, dynamic>> _bookingData = [
    {
      "time": "10:00 ",
      "date": "2023-05-05",
      "user_name": "joel",
      "items": ["hi", "how", "are"],
    },
    {
      "time": "10:00 ",
      "date": "2023-05-03",
      "user_name": "joel",
      "items": ["hi", "how", "are"],
    },
    {
      "time": "10:00 ",
      "date": "2023-05-04",
      "user_name": "joel",
      "items": ["hi", "how", "are"],
    },
    {
      "time": "12:00 ",
      "date": "2023-04-03",
      "user_name": "joel",
      "items": ["hi", "how", "are"],
    },
    {
      "time": "11:00 ",
      "date": "2023-04-03",
      "user_name": "joel",
      "items": ["hi", "how", "are"],
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
          'Purchase Details',
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
                          "Date: ${booking['date']}",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Username: ${booking['user_name']}",
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Items: ${booking['items']}",
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
