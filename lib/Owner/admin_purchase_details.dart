import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseAdminPage extends StatefulWidget {
  @override
  _PurchaseAdminPageState createState() => _PurchaseAdminPageState();
}

class _PurchaseAdminPageState extends State<PurchaseAdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _purchases = [];
  String _selectedFilter = 'Today';

  @override
  void initState() {
    super.initState();
    _fetchpurchases();
  }

  void _fetchpurchases() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('purchase')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _purchases = querySnapshot.docs;
    });
  }

  List<DocumentSnapshot> _getFilteredpurchases() {
    DateTime now = DateTime.now();
    if (_selectedFilter == 'Today') {
      return _purchases
          .where((purchase) =>
              purchase['date'].toDate().day == now.day &&
              purchase['date'].toDate().month == now.month &&
              purchase['date'].toDate().year == now.year)
          .toList();
    } else if (_selectedFilter == 'Yesterday') {
      DateTime yesterday = now.subtract(Duration(days: 1));
      return _purchases
          .where((purchase) =>
              purchase['date'].toDate().day == yesterday.day &&
              purchase['date'].toDate().month == yesterday.month &&
              purchase['date'].toDate().year == yesterday.year)
          .toList();
    } else if (_selectedFilter == 'This Month') {
      return _purchases
          .where((purchase) =>
              purchase['date'].toDate().month == now.month &&
              purchase['date'].toDate().year == now.year)
          .toList();
    } else {
      return _purchases;
    }
  }

  Widget _buildpurchaseItem(DocumentSnapshot purchase) {
    return ListTile(
      title: Text(
        'Items:${purchase['items_bought'].join(', ')}',
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
            'Total Price: ${purchase['total_price']}',
            style: GoogleFonts.bebasNeue(
              fontSize: 18,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'User Name: ${purchase['user_name']}',
            style: GoogleFonts.bebasNeue(
              fontSize: 18,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
          SizedBox(height: 5),
          Text(
            purchase['date'].toDate().toString(),
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
    List<DocumentSnapshot> filteredpurchases = _getFilteredpurchases();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 100,
        title: Text(
          'Purchase Deails',
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
                child: filteredpurchases.isEmpty
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
                        itemCount: filteredpurchases.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildpurchaseItem(filteredpurchases[index]),
                              if (index < filteredpurchases.length - 1)
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
