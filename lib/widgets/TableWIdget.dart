import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';

class CustomTableWidget extends StatelessWidget {
  final int index;

  // Use the index parameter in the constructor
  CustomTableWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * 0.1;
    var containerWidth = MediaQuery.of(context).size.width * 0.1;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: containerHeight,
        width: containerWidth,
        color: ColorsUsed.amber,
        child: Center(
            child: Text(
          "T$index ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
    );
  }
}
