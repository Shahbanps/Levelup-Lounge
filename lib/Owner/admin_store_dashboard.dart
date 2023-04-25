import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levelup/User/feedback.dart';

import '../User/change_password.dart';

class AdminStorePage extends StatefulWidget {
  @override
  _AdminStorePageState createState() => _AdminStorePageState();
}

class _AdminStorePageState extends State<AdminStorePage> {
  final List<Product> _products = [
    Product('Item 1', 9.99, "assets/PC.png"),
    Product('Item 2', 19.99, "assets/PC.png"),
    Product('Item 3', 4.99, "assets/PC.png"),
    Product('Item 4', 14.99, "assets/PC.png"),
    Product('Item 5', 7.99, "assets/PC.png"),
    Product('Item 6', 12.99, "assets/PC.png"),
    Product('Item 7', 2.99, "assets/PC.png"),
    Product('Item 8', 5.99, "assets/PC.png"),
    Product('Item 9', 3.99, "assets/PC.png"),
    Product('Item 10', 8.99, "assets/PC.png"),
  ];

  // final List<CartItem> _cartItems = [];

  // double _calculateTotal() {
  //   double total = 0.0;
  //   _cartItems.forEach((cartItem) {
  //     total += cartItem.product.price * cartItem.quantity;
  //   });
  //   return total;
  // }

  // void _addToCart(Product product) {
  //   bool itemFound = false;
  //   for (CartItem cartItem in _cartItems) {
  //     if (cartItem.product.name == product.name) {
  //       itemFound = true;
  //       setState(() {
  //         cartItem.quantity++;
  //       });
  //       break;
  //     }
  //   }
  //   if (!itemFound) {
  //     setState(() {
  //       _cartItems.add(CartItem(product, 1));
  //     });
  //   }
  // }

  // void _removeFromCart(CartItem cartItem) {
  //   setState(() {
  //     _cartItems.remove(cartItem);
  //   });
  // }

  // void _clearCart() {
  //   setState(() {
  //     _cartItems.clear();
  //   });
  // }

  // void _pay() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Payment',
  //           style: GoogleFonts.bebasNeue(
  //             fontSize: 15,
  //             color: Color.fromARGB(255, 224, 224, 224),
  //           ),
  //         ),
  //         content:
  //             Text('Total amount: \$${_calculateTotal().toStringAsFixed(2)}'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               _clearCart();
  //             },
  //             child: Text(
  //               'OK',
  //               style: GoogleFonts.bebasNeue(
  //                 fontSize: 15,
  //                 color: Color.fromARGB(255, 224, 224, 224),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
                              255, 26, 26, 26), // set the border color here
                          width: 0.5, // set the width of the border
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: InkWell(
                        onTap: () => () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen()),
                          );
                        },
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
                                  ? Image.asset(
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
              ),
            ),
            SizedBox(height: 6),
            // Text(
            //   'Cart:',
            //   style: GoogleFonts.bebasNeue(
            //     fontSize: 26,
            //     color: Color.fromARGB(255, 255, 255, 255),
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     // ignore: prefer_const_literals_to_create_immutables
            //     boxShadow: [
            //       BoxShadow(
            //           color: Color.fromARGB(255, 143, 143, 143), //New
            //           blurRadius: 0.2,
            //           offset: Offset(0, 0.2))
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(8.0, 3, 8, 3),
            //         child: Text(
            //           "Cart",
            //           style: GoogleFonts.bebasNeue(
            //             fontSize: 16,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 7),
            // Divider(
            //   color: Colors.white,
            //   height: 0,
            //   thickness: 0.3,
            // ),
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
                        MaterialPageRoute(builder: (context) => Feed_Back()),
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
            // Expanded(
            //   child: Container(
            //     // color: Colors.black,
            //     decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 0, 0, 0),
            //       border: Border.all(color: Color.fromARGB(255, 22, 22, 22)),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: ListView.builder(
            //       itemCount: _cartItems.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         CartItem cartItem = _cartItems[index];
            //         return ListTile(
            //           title: Text(
            //             '${cartItem.product.name} x ${cartItem.quantity}',
            //             style: GoogleFonts.bebasNeue(
            //               fontSize: 17,
            //               color: Color.fromARGB(255, 255, 255, 255),
            //             ),
            //           ),
            //           trailing: IconButton(
            //             icon: Icon(Icons.remove_shopping_cart),
            //             color: Colors.white,
            //             onPressed: () => _removeFromCart(cartItem),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            ,
            // SizedBox(height: 5),
            //       Text(
            //         '   Total:  \$${_calculateTotal().toStringAsFixed(2)}',
            //         style: GoogleFonts.bebasNeue(
            //           fontSize: 26,
            //           color: Color.fromARGB(255, 255, 255, 255),
            //         ),
            //       ),
            //       SizedBox(height: 5),
            //       Divider(
            //         color: Colors.white,
            //         height: 0,
            //         thickness: 0.3,
            //       ),
            //       SizedBox(height: 5),
            //       Center(
            //         child: ElevatedButton(
            //           onPressed: _pay,
            //           child: Padding(
            //             padding: const EdgeInsets.fromLTRB(175, 5, 175, 5),
            //             child: Text(
            //               'Pay',
            //               style: GoogleFonts.bebasNeue(
            //                 fontSize: 20,
            //                 color: Color.fromARGB(255, 0, 0, 0),
            //               ),
            //             ),
            //           ),
            //           style: ButtonStyle(
            //             backgroundColor:
            //                 MaterialStateProperty.all<Color>(Colors.yellow),
            //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10.0),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
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

// class CartItem {
//   final Product product;
//   int quantity;

//   CartItem(this.product, this.quantity);
// }
