import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:provider/provider.dart';

class InvoiceTakeAway extends StatelessWidget {
  final bool tabchoice;

  InvoiceTakeAway({required this.tabchoice});

  @override
  List<String> rowHeadings = ["SI NO", "NAME", "PRICE", "COUNT", "SUM"];

  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderClass>(context);
    int selectedTable = provider.selectedTableIndex;
    print("-----------------take away--------------");

    print("selected table comes inside invoice take away: $selectedTable");
    Map<int, Map<String, List<Food>>> cartMap = provider.cartMap;

    var selectedItemsT = provider.cartMap[selectedTable]!['takeAway']!;
    print("insdie the take away");
    selectedItemsT.forEach(
      (element) {
        print(element.productName);
      },
    );
    return Column(
      children: [
        ListTile(
          title: Row(
            children: rowHeadings
                .map(
                  (heading) => Expanded(
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
        ),
        Expanded(
          child: ListView.builder(
            itemCount: selectedItemsT.length,
            itemBuilder: (context, index) {
              var selectedItem = selectedItemsT[index];
              List<dynamic> rowData = [
                selectedItem.id,
                selectedItem.productName,
                selectedItem.price,
                selectedItem.count,
                (double.parse(selectedItem.price!) * selectedItem.count!)
                    .toStringAsFixed(2),
              ];

              return ListTile(
                title: Row(
                  children: rowData
                      .map(
                        (content) => Expanded(
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
                      MaterialStatePropertyAll(ColorsUsed.buttonColor),
                ),
                onPressed: () {
                  // Your button onPressed logic
                },
                child: Text("Done"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
