import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.bebasNeueTextTheme(),
      ),
      home: StorePage(),
    );
  }
}

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<CartItem> _cartItems = [];
  double _calculateTotal() {
    double total = 0.0;
    _cartItems.forEach((cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  void _addToCart(Product product) {
    bool itemFound = false;
    for (CartItem cartItem in _cartItems) {
      if (cartItem.product.name == product.name) {
        itemFound = true;
        setState(() {
          cartItem.quantity++;
        });
        break;
      }
    }
    if (!itemFound) {
      setState(() {
        _cartItems.add(CartItem(product, 1));
      });
    }
  }

  void _removeFromCart(CartItem cartItem) {
    setState(() {
      _cartItems.remove(cartItem);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  void _pay() async {
    // Get the current date and time
    DateTime now = DateTime.now();

    // Retrieve the current user
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Check if the user is authenticated and their ID is available
    if (user != null && user.uid != null) {
      String userId = user.uid;

      try {
        // Retrieve the user document from the "users" collection
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        // Check if the user document exists and contains the required fields
        if (userSnapshot.exists && userSnapshot.data() != null) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          String firstName = userData['firstName'];
          String lastName = userData['lastName'];

          // Create a purchase document with the required fields
          Map<String, dynamic> purchaseData = {
            'items_bought':
                _cartItems.map((cartItem) => cartItem.product.name).toList(),
            'total_price': _calculateTotal(),
            'date': now,
            'user_name': '$firstName $lastName',
            'user_id': userId, // Add the user ID to the purchase data
          };

          // Add the purchase document to the "purchase" collection
          await FirebaseFirestore.instance
              .collection('purchase')
              .add(purchaseData);

          // Show a success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.yellow,
                title: Text(
                  'Payment',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                content: Text(
                  'Total amount: \$${_calculateTotal().toStringAsFixed(2)}',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _clearCart();
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 15,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          // Show an error dialog if the user document is not found or does not contain the required fields
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Error',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 15,
                    color: Color.fromARGB(255, 224, 224, 224),
                  ),
                ),
                content: Text('Failed to retrieve user information.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 15,
                        color: Color.fromARGB(255, 224, 224, 224),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        // Show an error dialog if payment processing fails
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error',
                style: GoogleFonts.bebasNeue(
                  fontSize: 15,
                  color: Color.fromARGB(255, 224, 224, 224),
                ),
              ),
              content: Text('Payment processing failed.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 15,
                      color: Color.fromARGB(255, 224, 224, 224),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
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
              'Products',
              style: GoogleFonts.bebasNeue(
                fontSize: 27,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 2),
            Divider(
              color: Colors.white,
              height: 0,
              thickness: 0.3,
            ),
            Expanded(
              flex: 4,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Product> products = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final price = data['item_price'] != null
                        ? double.parse(data['item_price'].toString())
                        : 0.0;
                    return Product(
                      data['item_name'],
                      price,
                      data['image_url'],
                    );
                  }).toList();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color.fromARGB(
                                  255, 26, 26, 26), // set the border color here
                              width: 0.5, // set the width of the border
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 4.0,
                          child: InkWell(
                            onTap: () => _addToCart(product),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
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
                                SizedBox(height: 8),
                                Text(
                                  product.name,
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 143, 143, 143),
                    blurRadius: 0.2,
                    offset: Offset(0, 0.2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 3),
                    child: Text(
                      "Cart",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  border: Border.all(color: Color.fromARGB(255, 22, 22, 22)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: _cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    CartItem cartItem = _cartItems[index];
                    return ListTile(
                      title: Text(
                        '${cartItem.product.name} x ${cartItem.quantity}',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        color: Colors.white,
                        onPressed: () => _removeFromCart(cartItem),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              '   Total:  \$${_calculateTotal().toStringAsFixed(2)}',
              style: GoogleFonts.bebasNeue(
                fontSize: 26,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.white,
              height: 0,
              thickness: 0.3,
            ),
            SizedBox(height: 5),
            Center(
              child: ElevatedButton(
                onPressed: _pay,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(175, 5, 175, 5),
                  child: Text(
                    'Pay',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 20,
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
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String? imagePath;

  Product(this.name, this.price, this.imagePath);
}

class CartItem {
  final Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}
