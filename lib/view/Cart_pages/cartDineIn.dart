import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:provider/provider.dart';

var currentCount = 1;
var price = 0;

class CartDineIn extends StatefulWidget {
  const CartDineIn({Key? key}) : super(key: key);

  @override
  _CartDineInState createState() => _CartDineInState();
}

class _CartDineInState extends State<CartDineIn> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      var provider = Provider.of<ProviderClass>(context);
      int selectedTable = provider.selectedTableIndex;
      var selectedItemsD = provider.cartMap[selectedTable]!['dineIn']!;

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItemsD.length,
              itemBuilder: (context, index) {
                var currentItem = selectedItemsD[index];

                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Consumer(
                    builder: (context, value, child) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentItem.productName ?? "Default",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text(currentItem.price ?? "Default"),
                              Text(" X "),
                              Text("${currentItem.count}"),
                              Spacer(),
                              Text(
                                "Price: ${(double.parse(currentItem.price!) * (selectedItemsD[index].count ?? 0).toDouble())} ",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(currentItem.price);
                                  print("+ icon pressed");
                                  print("index is $index");
                                  try {
                                    double price =
                                        double.parse(currentItem.price!);
                                    int currentCount = currentItem.count!;

                                    bool isTakeAwayActive = false;

                                    Provider.of<ProviderClass>(context,
                                            listen: false)
                                        .increment(
                                      isTakeAwayActive: isTakeAwayActive,
                                      id: currentItem.id!,
                                      currentCount: currentCount,
                                      priceofItem: currentItem.price,
                                    );

                                    setState(() {});
                                  } catch (e) {
                                    print("Error parsing price: $e");
                                  }
                                },
                                child: Icon(Icons.add),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  print(
                                      "index is ${currentItem.id} and name is ${currentItem.productName}");
                                  Provider.of<ProviderClass>(context,
                                          listen: false)
                                      .removefromCart(
                                          id: currentItem.id!,
                                          count: currentItem.count,
                                          price: currentItem.price);
                                },
                                child: Icon(Icons.delete),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  print("index is $index");
                                  try {
                                    double price =
                                        double.parse(currentItem.price!);
                                    int currentCount = currentItem.count!;

                                    bool isTakeAwayActive = false;
                                    (currentCount > 1)
                                        ? Provider.of<ProviderClass>(context,
                                                listen: false)
                                            .decrement(
                                            isTakeAwayActive: isTakeAwayActive,
                                            id: currentItem.id!,
                                            currentCount: currentCount,
                                            priceofItem: currentItem.price,
                                          )
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Invalid Input! Count should be greater than zero")));

                                    setState(() {});
                                  } catch (e) {
                                    print("Error parsing price: $e");
                                  }
                                },
                                child: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                  "Total Cost: ${Provider.of<ProviderClass>(context).totalSumForTable[selectedTable].toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorsUsed.buttonColor),
                  ),
                  onPressed: () {
                    DateTime datetime = DateTime.now();
                    String dateStr = datetime.toString();
                    print("date time is: $dateStr");
                    Provider.of<ProviderClass>(context, listen: false)
                        .acceptedOrder();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Text("Kitchen")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(ColorsUsed.buttonColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesPage(),
                          ));
                    },
                    child: Text("Add Items")),
              )
            ],
          ),
        ],
      );
    });
  }
}
         // try {
                                //   double price =
                                //       double.parse(currentItem.price!);
                                //   currentCount = Provider.of<ProviderClass>(
                                //           context,
                                //           listen: false)
                                //       .selectedItemsForDineIn[index]
                                //       .count!
                                //       .toInt();
                                //   if (currentCount >= 1) {
                                //     Provider.of<ProviderClass>(context,
                                //             listen: false)
                                //         .decrement(
                                //             isTakeAwayActive: false,
                                //             id: currentItem.id!,
                                //             currentCount: currentCount,
                                //             priceofItem: currentItem.price);
                                //   } else {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text("Invalid option")),
                                //     );
                                //   }

                                //   setState(() {});
                                // } catch (e) {
                                //   print("Error parsing price: $e");
                                // }



                                // try {
                                //   double price =
                                //       double.parse(currentItem.price!);
                                //   currentCount = Provider.of<ProviderClass>(
                                //           context,
                                //           listen: false)
                                //       .selectedItemsForDineIn[index]
                                //       .count!
                                //       .toInt();
                                //   Provider.of<ProviderClass>(context,
                                //           listen: false)
                                //       .increment(
                                //     isTakeAwayActive: false,
                                //     id: currentItem.id!,
                                //     currentCount: currentCount,
                                //     priceofItem: currentItem.price,
                                //   );
                                //   setState(() {});
                                // } catch (e) {
                                //   print("Error parsing price: $e");
                                // }