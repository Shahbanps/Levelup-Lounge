import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SlotTimings extends StatefulWidget {
  const SlotTimings({super.key});

  @override
  State<SlotTimings> createState() => _SlotTimingsState();
}

class _SlotTimingsState extends State<SlotTimings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          padding: const EdgeInsets.only(top: 0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                width: constraints.maxWidth,
                height: 10,
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 19,
                    childAspectRatio:
                        1, // set the aspect ratio of each child widget
                  ),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {
                        // action to perform when button is pressed
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.yellow, // set the border color here
                              width: 0.5, // set the width of the border
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: Text('$index'),
                    );
                  },
                  itemCount: 12,
                ),
              );
            },
          )),
    );
  }
}
