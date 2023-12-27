import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/categories.dart';

class CustomFloatingActionButton {
  FloatingActionButton getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: ColorsUsed.ButtonPrimaryColor,
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesPage(),
          ),
        );
      },
    );
  }
}
