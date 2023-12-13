import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/cart.dart';
import 'package:flutter_application_1/view/sortedList.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

Map<int, bool> isCartButtonDisabled = {};

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<int> selectedIndices = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      print("the code is correct");
      await Provider.of<ProviderClass>(context, listen: false).fetchData();
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * 0.2;
    var containerWidth = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      appBar: CustomAppBar().getAppBar(title: "Items List"),
      body: Consumer<ProviderClass>(
        builder: (context, provider, child) {
          if (provider.responseData == null ||
              provider.responseData!.food == null) {
            return CircularProgressIndicator();
          }

          List<Food> responseData = provider.responseData!.food!;

          List<String> categoryNames = responseData
              .map((food) => food.categoryName ?? "default")
              .toSet()
              .toList(); // to avoid duplication in the list

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        "Choose your Category",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    var currentCategory = categoryNames[index];
                    var categoryItems = responseData
                        .where((food) => food.categoryName == currentCategory)
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SortedPage(
                                selectedCategory: currentCategory,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 211, 211, 211),
                            ),
                          ),
                          width: 100,
                          height: 70,
                          child: Center(
                            child: Column(
                              children: [
                                Image.network(
                                  categoryItems.first.image ?? "",
                                  height: 50,
                                  width: 50,
                                ),
                                Container(
                                  child: Center(child: Text(currentCategory)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "List of Items",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          // Handle cart button press
                          print("Selected Indices: $selectedIndices");
                          Provider.of<ProviderClass>(context, listen: false)
                              .addtoCart(ids: selectedIndices);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(),
                            ),
                          );
                        },
                        child: Text("Cart")),
                  )
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: containerHeight,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        var currentItem = responseData[index];
                        var isDisabled = isCartButtonDisabled[index] ?? false;

                        return Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorsUsed.borderColor),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Container(
                                          width: containerWidth,
                                          height: containerHeight * .5,
                                          child: Image.network(
                                            currentItem.image ?? "",
                                            fit: BoxFit.fill,
                                            errorBuilder: (BuildContext context,
                                                Object error,
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
                                          "     Price ${currentItem.price}" ??
                                              "Default",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: isDisabled
                                                ? null
                                                : () {
                                                    print(
                                                        "Item added to cart: ${currentItem.productName}");

                                                    setState(() {
                                                      isCartButtonDisabled[
                                                          index] = true;
                                                      selectedIndices
                                                          .add(index + 1);
                                                    });
                                                  },
                                            child: Text("Add to Cart"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: responseData.length,
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: FloatingActionButton(
                    //       backgroundColor: Colors.amber,
                    //       onPressed: () {
                    //         // Handle Done button press
                    //         print("Selected Indices: $selectedIndices");
                    //         Provider.of<ProviderClass>(context, listen: false)
                    //             .addtoCart(ids: selectedIndices);
                    //         Navigator.pushReplacement(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => CartPage(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text("Done"),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
