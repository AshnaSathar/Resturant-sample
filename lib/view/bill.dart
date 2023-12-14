import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: LottieBuilder.asset("assets/Animation - 1702544292158.json")),
    );
  }
}
