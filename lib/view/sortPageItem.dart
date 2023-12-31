import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:provider/provider.dart';

class SortPageItem extends StatefulWidget {
  final Food currentItem;

  SortPageItem({required this.currentItem});

  @override
  _SortPageItemState createState() => _SortPageItemState();
}

class _SortPageItemState extends State<SortPageItem> {
  @override
  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * 0.2;
    var containerWidth = MediaQuery.of(context).size.width * 0.25;

    var currentItem = widget.currentItem;
    // var provider = Provider.of<ProviderClass>(context, listen: false);

    // bool isInCart =
    //     provider.selectedItems.any((item) => item.id == currentItem.id);

    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsUsed.borderColor,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: containerWidth,
                      height: containerHeight * .1,
                      child: Image.network(
                        currentItem.image ?? "",
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: Center(
                              child: Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Text(currentItem.productName ?? "Default"),
                Row(
                  children: [
                    Text(
                      "     Price ${currentItem.price}" ?? "Default",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    // Switch(
                    //   value: currentItem.isTakeAwayActive,
                    //   onChanged: (value) {
                    //     currentItem.isTakeAwayActive = value;
                    //     provider.updateTabChoice(isDineIn: value);
                    //     setState(() {});
                    //   },
                    //   activeColor: Colors.green,
                    // ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorsUsed.buttonColor),
                        ),
                        onPressed: () {
                          // print("Button pressed");
                          // print(
                          //     "isTakeAwayActive: ${currentItem.isTakeAwayActive}");

                          List<Map<String, dynamic>> itemsToAdd = [
                            {
                              "id": currentItem.id,
                              "isTakeAway": currentItem.isTakeAwayActive
                            },
                          ];

                          Provider.of<ProviderClass>(
                            context,
                            listen: false,
                          ).addtoCart(itemsToAdd: itemsToAdd);
                        },
                        child: Text("Dine In"),
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
                          currentItem.isTakeAwayActive = true;
                          Provider.of<ProviderClass>(context, listen: false)
                              .updateTabChoice(isDineIn: false);
                          // print("Button pressed");
                          // print(
                          //     "isTakeAwayActive: ${currentItem.isTakeAwayActive}");

                          List<Map<String, dynamic>> itemsToAdd = [
                            {
                              "id": currentItem.id,
                              "isTakeAway": currentItem.isTakeAwayActive
                            },
                          ];

                          Provider.of<ProviderClass>(
                            context,
                            listen: false,
                          ).addtoCart(itemsToAdd: itemsToAdd);
                        },
                        child: Text("Take Away"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
