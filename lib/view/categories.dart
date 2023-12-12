import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/CategoryList.dart';
import 'package:flutter_application_1/view/cart.dart';

import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<bool> checkboxStates = List.generate(100, (index) => false);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsUsed.black,
        onPressed: () {
          print("Selected Indices: $selectedIndices");
          Provider.of<ProviderClass>(context, listen: false)
              .addtoCart(ids: selectedIndices);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(),
            ),
          );
        },
        child: Text("Done"),
      ),
      appBar: AppBar(
        title: Text("Items List"),
        backgroundColor: Colors.black,
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryList(),
                    ));
              },
              child: Icon(Icons.category))
        ],
      ),
      body: Consumer<ProviderClass>(
        builder: (context, provider, child) {
          if (provider.responseData == null ||
              provider.responseData!.food == null) {
            return CircularProgressIndicator();
          }

          List<Food> responseData = provider.responseData!.food!;

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        "Choose your Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 211, 211, 211))),
                        // margin: EdgeInsets.all(8),
                        width: 100,
                        height: 70,
                        child: Center(
                          child: Column(
                            children: [
                              Image.network(
                                  "https://www.herofincorp.com/public/admin_assets/upload/blog/64b91a06ab1c8_food%20business%20ideas.webp"),
                              Container(
                                  child: Center(child: Text("category name"))),
                            ],
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
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "List of Items",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    mainAxisExtent: containerHeight,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var currentItem = responseData[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorsUsed.borderColor),
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Checkbox(
                                          value: checkboxStates[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkboxStates[index] = value!;
                                              if (checkboxStates[index]) {
                                                selectedIndices.add(index + 1);
                                              } else {
                                                selectedIndices.remove(index);
                                              }
                                            });
                                          },
                                        ),
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
              ),
            ],
          );
        },
      ),
    );
  }
}
