import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/widgets/CustomFloatingActionButtonForcart.dart';
import 'package:flutter_application_1/widgets/CustomeButton.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

var currentCount = 1;

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var price;

  @override
  void initState() {
    getData();
    addToaddtoCart();
    super.initState();
  }

  Future<void> getData() async {
    try {
      await Provider.of<ProviderClass>(context, listen: false).fetchData();
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> addToaddtoCart() async {
    try {
      await Provider.of<ProviderClass>(context, listen: false).fetchData();
      Provider.of<ProviderClass>(context, listen: false).addtoCart(ids: []);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: CustomFloatingActionButton().getFloatingActionButton(context),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Cart"),
        leading: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(ColorsUsed.buttonColor),
          ),
          onPressed: () {
            print(
                "${Provider.of<ProviderClass>(context, listen: false).selectedIds}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CategoriesPage(),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Provider.of<ProviderClass>(context).selectedItems.isEmpty
          ? Center(
              child: Container(
                height: MediaQuery.sizeOf(context).height * .1,
                child: Lottie.asset('assets/Animation - 1702448401276.json'),
              ),
            )
          : Stack(
              children: [
                Consumer<ProviderClass>(
                  builder: (context, provider, child) {
                    List<Food> selectedItems = provider.selectedItems;

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var currentItem = selectedItems[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            child: Column(
                              children: [
                                Text(currentItem.productName ?? "Default"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 228, 228, 228),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            price = double.parse(
                                                currentItem.price!);
                                            currentCount =
                                                Provider.of<ProviderClass>(
                                                        context,
                                                        listen: false)
                                                    .selectedItems[index]
                                                    .count!
                                                    .toInt();
                                            Provider.of<ProviderClass>(context,
                                                    listen: false)
                                                .increment(
                                                    index: index,
                                                    currentCount: currentCount,
                                                    priceofItem:
                                                        selectedItems[index]
                                                            .price);

                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      Text(
                                          "${Provider.of<ProviderClass>(context, listen: false).selectedItems[index].count}"),
                                      Spacer(),
                                      Text(
                                          "Price: ${currentItem.price} * ${selectedItems[index].count} = ${(double.parse(currentItem.price!) * (selectedItems[index].count ?? 0).toDouble())}"),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 228, 228, 228),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            price = double.parse(
                                                currentItem.price!);
                                            currentCount =
                                                Provider.of<ProviderClass>(
                                                        context,
                                                        listen: false)
                                                    .selectedItems[index]
                                                    .count!
                                                    .toInt();
                                            if (currentCount > 0) {
                                              Provider.of<ProviderClass>(
                                                      context,
                                                      listen: false)
                                                  .decrement(
                                                      index: index,
                                                      currentCount:
                                                          currentCount,
                                                      priceofItem:
                                                          selectedItems[index]
                                                              .price);
                                              setState(
                                                () {},
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content:
                                                        Text("Invalid option")),
                                              );
                                            }
                                          },
                                          child: Icon(
                                            Icons.minimize,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // isCartButtonDisabled[index] = false;
                                    });
                                    Provider.of<ProviderClass>(context,
                                            listen: false)
                                        .removeFromcart(
                                            index: index,
                                            currentCount: currentCount,
                                            priceofItem:
                                                selectedItems[index].price);
                                    // print(
                                    //     " inside the remove code$isCartButtonDisabled");
                                    print("index inside the remove:$index");
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: selectedItems.length,
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorsUsed.buttonColor)),
                            onPressed: () {
                              if (Provider.of<ProviderClass>(context,
                                      listen: false)
                                  .selectedItems
                                  .every((item) => item.count! > 0)) {
                                isSendKitchen = !isSendKitchen;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "You should choose an item count")),
                                );
                              }
                            },
                            child: Text("Send to kitchen"),
                          ),
                        ),
                        Text(
                          "Total Cost:${Provider.of<ProviderClass>(context).totalSum}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorsUsed.buttonColor),
                            ),
                            onPressed: () {
                              Provider.of<ProviderClass>(context, listen: false)
                                  .tableIndexOff(index: tableIndex);
                            },
                            child: Text("Give Order"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
