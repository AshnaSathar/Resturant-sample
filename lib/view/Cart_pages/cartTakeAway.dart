import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:provider/provider.dart';

var currentCount = 0;
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
      List<Food> selectedItemsT =
          Provider.of<ProviderClass>(context).selectedItemsForTakeAway;

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
                                print("index is $index");
                                try {
                                  double price =
                                      double.parse(currentItem.price!);
                                  currentCount = Provider.of<ProviderClass>(
                                          context,
                                          listen: false)
                                      .selectedItemsForTakeAway[index]
                                      .count!
                                      .toInt();
                                  Provider.of<ProviderClass>(context,
                                          listen: false)
                                      .increment(
                                          isTakeAwayActive: true,
                                          id: currentItem.id!,
                                          currentCount: currentCount,
                                          priceofItem: currentItem.price);
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
                                try {
                                  double price =
                                      double.parse(currentItem.price!);
                                  currentCount = Provider.of<ProviderClass>(
                                          context,
                                          listen: false)
                                      .selectedItemsForTakeAway[index]
                                      .count!;

                                  Provider.of<ProviderClass>(context,
                                          listen: false)
                                      .removeFromcart(
                                          id: currentItem.id!,
                                          isTakeAwayActive: true,
                                          currentCount: currentCount,
                                          priceofItem:
                                              selectedItemsT[index].price);
                                } catch (e) {
                                  print("Error parsing price: $e");
                                }
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
                                  currentCount = Provider.of<ProviderClass>(
                                          context,
                                          listen: false)
                                      .selectedItemsForTakeAway[index]
                                      .count!
                                      .toInt();
                                  if (currentCount >= 1) {
                                    Provider.of<ProviderClass>(context,
                                            listen: false)
                                        .decrement(
                                            isTakeAwayActive: true,
                                            id: currentItem.id!,
                                            currentCount: currentCount,
                                            priceofItem: currentItem.price);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Invalid option")),
                                    );
                                  }

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
                  "Total Cost: ${Provider.of<ProviderClass>(context).totalSum.toString()}",
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
          SizedBox(height: 16.0),
        ],
      );
    });
  }
}
