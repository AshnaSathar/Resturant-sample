import 'package:flutter/material.dart';

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
