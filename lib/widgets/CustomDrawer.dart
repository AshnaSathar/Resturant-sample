import 'package:flutter/material.dart';

bool isSendKitchen = false;

class CustomDrawer extends StatelessWidget {
  CustomDrawer();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Text("Home"),
          Text("Categories"),
          Text("Table"),
        ],
      ),
    );
  }
}
