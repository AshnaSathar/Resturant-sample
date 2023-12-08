import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/view/Login.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderClass(),
      child: MaterialApp(

          // home: LoginPage(),
          home: CategoriesPage()),
    );
  }
}
