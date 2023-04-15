import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import 'model/cart_model.dart';
import 'cart_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'Store',
            style: GoogleFonts.bebasNeue(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press here
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CartPage();
            },
          ),
        ),
        child: const Icon(Icons.shopping_bag),
      ),
      body: Container(
        color: Color.fromARGB(255, 30, 30, 30),
        child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 48),

              // good morning bro
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Hey you,',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 4),

              // Let's order fresh items for you
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Let's boost your energy",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 1),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Divider(),
              ),

              const SizedBox(height: 1),

              // categories -> horizontal listview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Cool Items",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),

              // recent orders -> show last 3
              Expanded(
                child: Consumer<CartModel>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      itemCount: value.shopItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.2,
                      ),
                      itemBuilder: (context, index) {
                        return GroceryItemTile(
                          itemName: value.shopItems[index][0],
                          itemPrice: value.shopItems[index][1],
                          imagePath: value.shopItems[index][2],
                          color: value.shopItems[index][3],
                          onPressed: () =>
                              Provider.of<CartModel>(context, listen: false)
                                  .addItemToCart(index),
                        );
                      },
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
