import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/cart.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class SortedPage extends StatefulWidget {
  final String? selectedCategory;
  const SortedPage({super.key, required this.selectedCategory});

  @override
  State<SortedPage> createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
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
    CustomAppBar appBarObject = CustomAppBar();

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
      appBar: appBarObject.getAppBar(title: "${widget.selectedCategory}"),
      body: Consumer<ProviderClass>(
        builder: (context, provider, child) {
          if (provider.responseData == null ||
              provider.responseData!.food == null) {
            return CircularProgressIndicator();
          }

          List<Food> responseData = provider.responseData!.food!;
          var categoryItems = responseData
              .where((food) => food.categoryName == widget.selectedCategory)
              .toList();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: containerHeight,
            ),
            itemBuilder: (BuildContext context, int index) {
              var currentItem = categoryItems[index];
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsUsed.borderColor),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: containerHeight * .5,
                          color: Colors.green,
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
                        Text(currentItem.productName ?? "Default"),
                        Row(
                          children: [
                            Text(
                              "     Price ${currentItem.price}" ?? "Default",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                ],
              );
            },
            itemCount: categoryItems.length,
          );
        },
      ),
    );
  }
}
