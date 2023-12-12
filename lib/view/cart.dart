import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/widgets/CustomBottomNavigationBar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var count = 0;
  var currentCount = 0;
  var price;
  var sum;
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
      Provider.of<ProviderClass>(context, listen: false).addtoCart(ids: [3, 1]);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Stack(
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
                                      price = double.parse(currentItem.price!);
                                      currentCount = Provider.of<ProviderClass>(
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
                                                  selectedItems[index].price);

                                      setState(() {
                                        // sum[index] =
                                        //     (double.parse(currentItem.price!) *
                                        //         (selectedItems[index].count ??
                                        //                 0)
                                        //             .toDouble());
                                        // print(sum[index]);
                                        // for (int i = 0; i <= index; i++) {
                                        //   sum = sum + sum[i];
                                        // }
                                      });
                                      // print("sum=$sum");
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
                                      price = double.parse(currentItem.price!);
                                      currentCount = Provider.of<ProviderClass>(
                                              context,
                                              listen: false)
                                          .selectedItems[index]
                                          .count!
                                          .toInt();
                                      if (currentCount > 0) {
                                        Provider.of<ProviderClass>(context,
                                                listen: false)
                                            .decrement(
                                                index: index,
                                                currentCount: currentCount,
                                                priceofItem:
                                                    selectedItems[index].price);
                                        setState(
                                          () {},
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text("Invalid option")),
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
                                Provider.of<ProviderClass>(context,
                                        listen: false)
                                    .removeFromcart(
                                        index: index,
                                        currentCount: currentCount,
                                        priceofItem:
                                            selectedItems[index].price);
                              },
                              icon: Icon(Icons.delete)),
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
                          onPressed: () {}, child: Text("Send to kitchen")),
                    ),
                    Text(
                      "Total Cost:${Provider.of<ProviderClass>(context).totalSum}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Give Order"),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
