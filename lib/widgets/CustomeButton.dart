import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Table.dart';

bool isSendKitchen = false;
bool isSendKitchenDineIn = false;
bool isSendKitchenTakeAway = false;

class ButtonWidget extends StatelessWidget {
  final title;
  ButtonWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ColorsUsed.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          if (title == "Login" || title == "login") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TablesPage(),
              ),
            );
          }
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
