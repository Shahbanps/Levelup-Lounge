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
        textTheme: GoogleFonts.bebasNeueTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          headline6: GoogleFonts.bebasNeue(
            textStyle: Theme.of(context).textTheme.headline6,
            fontSize: 28,
            color: Colors.yellow,
          ),
        ),
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

  void _pay() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Payment',
            style: GoogleFonts.bebasNeue(
              fontSize: 15,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
          content:
              Text('Total amount: \$${_calculateTotal().toStringAsFixed(2)}'),
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
                  color: Color.fromARGB(255, 224, 224, 224),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Store',
          style: GoogleFonts.bebasNeue(
            fontSize: 15,
            color: Color.fromARGB(255, 224, 224, 224),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products:',
              style: GoogleFonts.bebasNeue(
                fontSize: 24,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                ),
                itemCount: _products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = _products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
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
                              color: Color.fromARGB(255, 224, 224, 224),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 20,
                              color: Color.fromARGB(255, 224, 224, 224),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Cart:',
              style: GoogleFonts.bebasNeue(
                fontSize: 24,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  CartItem cartItem = _cartItems[index];
                  return ListTile(
                    title: Text(
                      '${cartItem.product.name} x ${cartItem.quantity}',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 18,
                        color: Color.fromARGB(255, 224, 224, 224),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () => _removeFromCart(cartItem),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Total: ${_calculateTotal().toStringAsFixed(2)}',
              style: GoogleFonts.bebasNeue(
                fontSize: 24,
                color: Color.fromARGB(255, 224, 224, 224),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pay,
              child: Text('Pay'),
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
