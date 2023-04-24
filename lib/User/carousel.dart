import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CarouselBox extends StatelessWidget {
  const CarouselBox({super.key, required this.description, required this.url});
  final String description;
  final String url;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment
            .bottomCenter, // align the child to the bottom center of the container
        child: FractionallySizedBox(
          widthFactor:
              1.0, // set the width factor to 1.0 to fill the available width
          child: Padding(
            padding: EdgeInsets.all(8.0), // add some padding
            child: Text(
              description,
              style: TextStyle(
                color: Colors.white, // set the text color
                fontSize: 16.0, // set the font size
              ),
            ),
          ),
        ),
      ),
    );
  }
}
