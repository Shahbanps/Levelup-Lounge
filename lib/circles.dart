import "package:flutter/material.dart";

class Mycircle extends StatelessWidget {
  final child;

  Mycircle({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, color: Color.fromARGB(255, 250, 227, 54)),
      child: Center(child: Text(child, style: TextStyle(fontSize: 10))),
    );
  }
}
