import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final inputType;

  AppTextField({required this.title, required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: title,
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
