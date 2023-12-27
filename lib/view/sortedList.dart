import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Cart_pages/cart.dart';
import 'package:flutter_application_1/view/sortPageItem.dart';
import 'package:provider/provider.dart'; // Import the new widget

class SortedPage extends StatefulWidget {
  final String? selectedCategory;

  const SortedPage({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  State<SortedPage> createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
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
        backgroundColor: ColorsUsed.ButtonPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(),
            ),
          );

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
                        (food) => food.categoryName == widget.selectedCategory)
                    .toList();

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var currentItem = categoryItems[index];

                    return SortPageItem(currentItem: currentItem);
                  },
                  itemCount: categoryItems.length,
                );
              },
            ),
    );
  }
}
