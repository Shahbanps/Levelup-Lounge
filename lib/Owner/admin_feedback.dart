import 'package:flutter/material.dart';

class FeedbackPreview extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String phoneNumber;
  final String categoryCode;

  FeedbackPreview({
    required this.imageUrl,
    required this.description,
    required this.phoneNumber,
    required this.categoryCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Phone Number: $phoneNumber',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Category Code: $categoryCode',
                    style: TextStyle(
                      fontFamily: 'Bebas Neue',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
