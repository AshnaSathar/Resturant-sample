import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Table.dart';

class CustomTableWidget extends StatelessWidget {
  final int index;

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
        color: isSelectedTable[index] ? Colors.green : Colors.red,
        child: Center(
            child: Text(
          "T${index + 1} ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
    );
  }
}
