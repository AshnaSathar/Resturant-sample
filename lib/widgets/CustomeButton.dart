import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Home.dart';

class ButtonWidget extends StatelessWidget {
  final title;
  ButtonWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.black)),
        onPressed: () {
          if (title == "Login" || title == "login") {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          }
        },
        child: Text(title),
      ),
    );
  }
}
