import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedbackAdminPage extends StatefulWidget {
  @override
  _FeedbackAdminPageState createState() => _FeedbackAdminPageState();
}

class _FeedbackAdminPageState extends State<FeedbackAdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _feedbacks = [];
  String _selectedFilter = 'Today';

  @override
  void initState() {
    super.initState();
    _fetchFeedbacks();
  }

  void _fetchFeedbacks() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('feedback')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _feedbacks = querySnapshot.docs;
    });
  }

  List<DocumentSnapshot> _getFilteredFeedbacks() {
    DateTime now = DateTime.now();
    if (_selectedFilter == 'Today') {
      return _feedbacks
          .where((feedback) =>
              feedback['date'].toDate().day == now.day &&
              feedback['date'].toDate().month == now.month &&
              feedback['date'].toDate().year == now.year)
          .toList();
    } else if (_selectedFilter == 'Yesterday') {
      DateTime yesterday = now.subtract(Duration(days: 1));
      return _feedbacks
          .where((feedback) =>
              feedback['date'].toDate().day == yesterday.day &&
              feedback['date'].toDate().month == yesterday.month &&
              feedback['date'].toDate().year == yesterday.year)
          .toList();
    } else if (_selectedFilter == 'This Month') {
      return _feedbacks
          .where((feedback) =>
              feedback['date'].toDate().month == now.month &&
              feedback['date'].toDate().year == now.year)
          .toList();
    } else {
      return _feedbacks;
    }
  }

  Widget _buildFeedbackItem(DocumentSnapshot feedback) {
    return ListTile(
      title: Text(
        feedback['feedback_type'],
        style: GoogleFonts.bebasNeue(
          fontSize: 18,
          color: Color.fromARGB(255, 224, 224, 224),
        ),
      ),
      subtitle: Text(
        feedback['date'].toDate().toString(),
        style: GoogleFonts.bebasNeue(
          fontSize: 18,
          color: Color.fromARGB(255, 224, 224, 224),
        ),
      ),
      onTap: () {
        // Retrieve complete feedback details using feedback.id
        String feedbackId = feedback.id;
        DocumentReference feedbackRef =
            _firestore.collection('feedback').doc(feedbackId);

        feedbackRef.get().then((snapshot) {
          if (snapshot.exists) {
            Map<String, dynamic> feedbackData =
                snapshot.data() as Map<String, dynamic>;
            showDialog(
              barrierColor: Color.fromARGB(255, 0, 0, 0),
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.yellow,
                  contentPadding: EdgeInsets.symmetric(horizontal: 24),
                  title: Text(
                    'Feedback Details',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 22,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  content: Container(
                    height: 400,
                    child: SingleChildScrollView(
                      // Wrap the content with SingleChildScrollView
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Type: ${feedbackData['feedback_type']}',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Date: ${feedbackData['date'].toDate().toString()}',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Phone Number: ${feedbackData['phone_number']}',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Description: ${feedbackData['description']}',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 15,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              feedbackData['screenshot_url'],
                                          fit: BoxFit.contain,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons
                                                  .error), // Replace with your custom error handling widget
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: IconButton(
                            //     icon: Icon(Icons.image),
                            //     onPressed: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return Dialog(
                            //             child: Container(
                            //               width:
                            //                   MediaQuery.of(context).size.width *
                            //                       0.8,
                            //               height:
                            //                   MediaQuery.of(context).size.height *
                            //                       0.8,
                            //               child: CachedNetworkImage(
                            //                 imageUrl:
                            //                     feedbackData['screenshot_url'],
                            //                 fit: BoxFit.contain,
                            //               ),
                            //             ),
                            //           );
                            //         },
                            //       );
                            //     },
                            //   ),
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }).catchError((error) {
          // Handle error while retrieving feedback details
          print('Error retrieving feedback details: $error');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> filteredFeedbacks = _getFilteredFeedbacks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 100,
        title: Center(
          child: Text(
            'Feedback',
            style: GoogleFonts.bebasNeue(
              fontSize: 35,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
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
              Expanded(
                child: filteredFeedbacks.isEmpty
                    ? Center(
                        child: Text(
                          'No feedbacks',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 35,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredFeedbacks.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildFeedbackItem(filteredFeedbacks[index]),
                              if (index < filteredFeedbacks.length - 1)
                                Divider(
                                  color: Color.fromARGB(255, 0, 0, 0),
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
