import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Firestore package

import '../User/change_password.dart';
import 'add_item_store.dart';
import 'edit_item.dart';

class AdminStorePage extends StatefulWidget {
  @override
  _AdminStorePageState createState() => _AdminStorePageState();
}

class _AdminStorePageState extends State<AdminStorePage> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  CollectionReference<Map<String, dynamic>> itemsCollection =
      FirebaseFirestore.instance.collection('items');
  void fetchProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('items').get();

    List<Product> products = snapshot.docs.map((doc) {
      return Product(
        doc.id,
        doc['item_name'],
        double.parse(doc['item_price'].toString()),
        doc['image_url'],
      );
    }).toList();

    setState(() {
      _products = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 100,
        title: Center(
          child: Text(
            'Store',
            style: GoogleFonts.bebasNeue(
              fontSize: 35,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
        ),
      ),
      body: Container(
        height: 800,
        color: Color.fromARGB(255, 25, 25, 25),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Products',
              style: GoogleFonts.bebasNeue(
                fontSize: 30,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white,
              height: 0,
              thickness: 0.3,
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                ),
                itemCount: _products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = _products[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color.fromARGB(
                            255,
                            26,
                            26,
                            26,
                          ), // set the border color here
                          width: 0.5, // set the width of the border
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditItem(
                                      productId: product
                                          .id), // Pass the product ID to EditItem
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black,
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: product.imagePath != null
                                  ? Image.network(
                                      product.imagePath!,
                                      height: 100.0,
                                      width: 100.0,
                                    )
                                  : Icon(
                                      Icons.image,
                                      size: 50.0,
                                    ),
                            ),
                          ),
                          SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditItem(
                                      productId: product
                                          .id), // Pass the product ID to EditItem
                                ),
                              );
                            },
                            child: Text(
                              product.name,
                              style: GoogleFonts.bebasNeue(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 18,
                              color: Color.fromARGB(255, 226, 200, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 6),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 65,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddItem()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(90, 5, 90, 5),
                      child: Text(
                        'Add Item',
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
                  // SizedBox(
                  //   width: 30,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String? imagePath;

  Product(this.id, this.name, this.price, this.imagePath);
}
