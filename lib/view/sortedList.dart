import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/cart.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class SortedPage extends StatefulWidget {
  final String? selectedCategory;

  const SortedPage({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  State<SortedPage> createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
  List<int> selectedIndices = [];
  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      print("Fetching data for category: ${widget.selectedCategory}");
      await Provider.of<ProviderClass>(context, listen: false).fetchData();
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching data: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUsed.appBarColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("${widget.selectedCategory}"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsUsed.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(),
            ),
          );

          Provider.of<ProviderClass>(context, listen: false)
              .addtoCart(ids: selectedIndices);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Items added to cart."),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Text("cart"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<ProviderClass>(
              builder: (context, provider, child) {
                if (provider.responseData == null ||
                    provider.responseData!.food == null) {
                  return Center(child: Text("No data available"));
                }

                List<Food> responseData = provider.responseData!.food!;
                var categoryItems = responseData
                    .where(
                      (food) => food.categoryName == widget.selectedCategory,
                    )
                    .toList();

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: containerHeight / 0.2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var currentItem = categoryItems[index];

                    // Check if the item is in the cart
                    bool isInCart = provider.selectedItems
                        .any((item) => item.id == currentItem.id);

                    // Check if the item is disabled
                    bool isDisabled =
                        provider.idtoDisable.any((id) => id == currentItem.id);

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDisabled
                                    ? Colors.grey
                                    : ColorsUsed.borderColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: containerHeight * 0.5,
                                  color: Colors.green,
                                  child: Image.network(
                                    currentItem.image ?? "",
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
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
                                            ? () {
                                                Provider.of<ProviderClass>(
                                                        context,
                                                        listen: false)
                                                    .removeFromcart(
                                                        index: index,
                                                        currentCount:
                                                            currentCount,
                                                        priceofItem:
                                                            currentItem.price);
                                              }
                                            : isInCart
                                                ? () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Item already in cart."),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      ),
                                                    );
                                                  }
                                                : () {
                                                    selectedIndices.add(
                                                        currentItem.id!
                                                            .toInt());
                                                    provider.addtoCart(
                                                      ids: selectedIndices,
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Item added to cart."),
                                                        duration: Duration(
                                                            seconds: 2),
                                                      ),
                                                    );
                                                  },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: isDisabled
                                              ? Colors.grey
                                              : isInCart
                                                  ? Colors.red
                                                  : Colors.green,
                                        ),
                                        child: Text(isInCart
                                            ? "In Cart"
                                            : isDisabled
                                                ? "Disabled"
                                                : "Add to Cart"),
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
                  itemCount: categoryItems.length,
                );
              },
            ),
    );
  }
}
