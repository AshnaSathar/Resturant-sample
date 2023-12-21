import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:flutter_application_1/view/Invoice_Pages/invoiceDineIn.dart';
import 'package:flutter_application_1/view/Invoice_Pages/invoiceTakeAway.dart';
import 'package:flutter_application_1/widgets/CustomFloatingActionButtonForcart.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
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
    bool tabChoice = Provider.of<ProviderClass>(context).tabchoice ?? false;
    print("hey your tabchoice is $tabChoice");

    return Scaffold(
        body: tabChoice
            ? InvoiceDineIn(tabchoice: true)
            : InvoiceTakeAway(tabchoice: false));
  }
}
