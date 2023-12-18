import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constants.dart';

class CustomSnackBar {
  getSnackBar() {
    return SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
  }
}
