import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Store',
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
    Product('Product 1', 10),
    Product('Product 2', 20),
    Product('Product 3', 30),
    Product('Product 4', 40),
    Product('Product 5', 50),
  ];

  final List<Product> _cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.remove(product);
    });
  }

  double _calculateTotal() {
    double total = 0;
    for (var product in _cartItems) {
      total += product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Store'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () => _addToCart(product),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = _cartItems[index];
                          return ListTile(
                            title: Text(cartItem.name),
                            subtitle:
                                Text('\$${cartItem.price.toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_shopping_cart),
                              onPressed: () => _removeFromCart(cartItem),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      'Total: \$${_calculateTotal().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Checkout'),
                      onPressed: () {
                        // TODO: implement checkout functionality
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}
