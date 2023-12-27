import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/unwanted/invoiceDineIn.dart';
import 'package:flutter_application_1/unwanted/invoiceTakeAway.dart';
import 'package:provider/provider.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  List<String> rowHeadings = ["SI NO", "NAME", "PRICE", "COUNT", "SUM"];

  @override
  Widget build(BuildContext context) {
    bool isTakeAwayActive =
        Provider.of<ProviderClass>(context).isTakeAwayActive ?? false;

    return Scaffold(
      body: isTakeAwayActive
          ? InvoiceTakeAway(
              tabchoice: true,
            )
          : InvoiceDineIn(tabchoice: false),
    );
  }
}
