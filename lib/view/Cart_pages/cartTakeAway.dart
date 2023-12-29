import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:provider/provider.dart';

var currentCount = 1;
var price = 0;

class CartTakeAway extends StatefulWidget {
  const CartTakeAway({Key? key}) : super(key: key);

  @override
  _CartTakeAwayState createState() => _CartTakeAwayState();
}

class _CartTakeAwayState extends State<CartTakeAway> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, provider, child) {
      var provider = Provider.of<ProviderClass>(context);
      int selectedTable = provider.selectedTableIndex;

      Map<int, Map<String, List<Food>>> cartMap = provider.cartMap;

      // Map<String, List<Food>> selectedTableMap = cartMap[selectedTable]!;
      // print("the table index is inside cart dine in: ${selectedTable}");
      provider.cartMap[selectedTable]!['takeAway']!.toList().forEach(
        (element) {
          // print("just for checking: ${element.productName}");
        },
      );

      var selectedItemsT = provider.cartMap[selectedTable]!['takeAway']!;

      Provider.of<ProviderClass>(context)
          .cartMap[selectedTable]!['takeAway']!
          .forEach((element) {
        print("for Checking");
        print(element.productName);
      });
      selectedItemsT.forEach((foods) {
        if (foods.productName != null) {
          print(foods.productName!);
        } else {
          print("ProductName is null for item ID: ${foods.id}");
        }
      });

      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItemsT.length,
              itemBuilder: (context, index) {
                var currentItem = selectedItemsT[index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
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
                              "Price: ${(double.parse(currentItem.price!) * (selectedItemsT[index].count ?? 0).toDouble())} ",
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
                                print("+ icon pressed");
                                print("index is $index");
                                try {
                                  double price =
                                      double.parse(currentItem.price!);
                                  int currentCount = currentItem.count!;

                                  bool isTakeAwayActive = true;

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
                                Provider.of<ProviderClass>(context,
                                        listen: false)
                                    .removefromCartTakeAway(
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

                                  bool isTakeAwayActive = true;
                                  (currentCount > 0)
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
                    print("=================inside");
                    DateTime datetime = DateTime.now();
                    String dateStr = datetime.toString();
                    print("date time is: $dateStr");
                    Provider.of<ProviderClass>(context, listen: false)
                        .acceptedOrder();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
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
