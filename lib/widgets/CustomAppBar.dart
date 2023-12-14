import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';

class CustomAppBar {
  getAppBar({required String title}) {
    return AppBar(
      backgroundColor: ColorsUsed.black,

      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
        ],
      ),
      // leading: Icon(Icons.arrow_back_ios_new_sharp),
    );
  }
}
