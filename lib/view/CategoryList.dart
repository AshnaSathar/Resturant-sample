import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/sortedList.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
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
    var categoryname;

    var containerHeight = MediaQuery.of(context).size.height * 0.3;
    var containerWidth = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      appBar: CustomAppBar().getAppBar(title: "categories"),
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
          return GridView.builder(
            itemCount: categoryNames.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: containerHeight,
            ),
            itemBuilder: (context, categoryIndex) {
              var currentCategory = categoryNames[categoryIndex];
              var categoryItems = responseData
                  .where((food) => food.categoryName == currentCategory)
                  .toList(); // to fetch corresponding image
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    categoryname = currentCategory;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SortedPage(selectedCategory: currentCategory),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 225, 224, 224),
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    height: containerHeight,
                    width: containerWidth,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 178, 177, 177))),
                                      height: containerHeight / 2,
                                      width: containerWidth,
                                      child: Image.network(
                                          categoryItems.first.image ?? "")),
                                )
                              ],
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                child: Text(
                                  categoryNames[categoryIndex] ?? "default",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
