import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Table.dart';

import 'package:flutter_application_1/widgets/CustomFloatingActionButtonForcart.dart';

import 'package:lottie/lottie.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:material_dialogs/material_dialogs.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  List<String> rowHeading = ["SI NO", "NAME", "PRICE", "COUNT", "SUM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: CustomFloatingActionButton().getFloatingActionButton(context),
      ),
      body: Column(
        children: [
          Table(
            children: [
              TableRow(
                children: rowHeading
                    .map(
                      (heading) => TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              heading,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  Provider.of<ProviderClass>(context).selectedItems.length,
              itemBuilder: (context, index) {
                var selectedItem =
                    Provider.of<ProviderClass>(context).selectedItems[index];
                List<dynamic> rowContent = [
                  selectedItem.id,
                  selectedItem.productName,
                  selectedItem.price,
                  selectedItem.count,
                  (double.parse(selectedItem.price!) *
                      (selectedItem.count!).toDouble())
                ];

                return Table(
                  children: [
                    TableRow(
                      children: rowContent
                          .map(
                            (content) => TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(
                                    "$content",
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Total Cost: ${Provider.of<ProviderClass>(context).totalSum}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorsUsed.buttonColor)),
                    onPressed: () {
                      Dialogs.materialDialog(
                          color: Colors.white,
                          title: 'Order Completed Successfully',
                          lottieBuilder: Lottie.asset(
                            'assets/Animation - 1702544292158.json',
                            fit: BoxFit.contain,
                          ),
                          context: context,
                          actions: [
                            IconsButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TablesPage()),
                                  (route) => false,
                                );
                              },
                              text: 'Exit',
                              iconData: Icons.done,
                              color: Colors.blue,
                              textStyle: TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ]);
                    },
                    child: Text("done")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
