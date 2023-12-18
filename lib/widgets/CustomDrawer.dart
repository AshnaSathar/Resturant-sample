import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/CategoryList.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:flutter_application_1/view/categories.dart';

class CustomDrawer {
  getDrawer({required context}) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "RESTURANT NAME",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text("HOME"),
            leading: Icon(
              Icons.home,
              color: Colors.green,
            ),
          ),
          Divider(),
          ListTile(
            title: Text("CATEGORIES"),
            leading: Icon(
              Icons.category,
              color: Colors.amber,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryList(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            title: Text("ALL ITEMS"),
            leading: Icon(
              Icons.trolley,
              color: Colors.pink,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesPage(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            title: Text("TABLES"),
            leading: Icon(
              Icons.table_bar_outlined,
              color: Colors.purple,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TablesPage(),
                  ));
            },
          ),
          Divider(),
          ListTile(
            title: Text("SETTINGS"),
            leading: Icon(
              Icons.settings,
              color: Colors.red,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text("LOGOUT"),
            leading: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/view/CategoryList.dart';
// import 'package:flutter_application_1/view/Table.dart';
// import 'package:flutter_application_1/view/categories.dart';

// bool isSendKitchen = false;

// class CustomDrawer extends StatelessWidget {
//   CustomDrawer();
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
