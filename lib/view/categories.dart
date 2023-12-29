import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Cart_pages/cart.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

List<String> searchList = [];
List<bool> isSelectedTable = List.generate(100, (index) => false);

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<int> selectedIndices = [];
  bool isSearchVisible = true;
  TextEditingController textController = TextEditingController();

  String selectedCategory = "";
  String searchText = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      await Provider.of<ProviderClass>(context, listen: false).fetchData();
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderClass>(context);
    List<Food> responseData = provider.responseData!.food!;
    List<String> searchList =
        responseData.map((food) => food.productName ?? "default").toList();

    var containerHeight = MediaQuery.of(context).size.height * 0.2;
    var containerWidth = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
        appBar: AppBar(
            title: Text("LIST"),
            backgroundColor: ColorsUsed.black,
            actions: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage()));
                      },
                      child: Icon(Icons.trolley)))
            ]),
        body: Consumer<ProviderClass>(builder: (context, provider, child) {
          if (provider.responseData == null ||
              provider.responseData!.food == null) {
            return CircularProgressIndicator();
          }
          List<Food> responseData = provider.responseData!.food!;
          List<String> categoryNames = responseData
              .map((food) => food.categoryName ?? "default")
              .toSet()
              .toList();
          List<SearchFieldListItem<String>> searchFieldItems = searchList
              .map((item) => SearchFieldListItem<String>(item))
              .toList();
          List<Food> displayedItems = [];
          if (selectedCategory.isNotEmpty) {
            // User selected a category, filter by category
            displayedItems = responseData
                .where((food) => food.categoryName == selectedCategory)
                .toList();
          } else if (searchText.isNotEmpty) {
            // User entered a search query, filter by search query
            displayedItems = responseData
                .where((food) => food.productName!
                    .toLowerCase()
                    .contains(searchText.toLowerCase()))
                .toList();
          } else {
            // Show all items
            displayedItems = responseData;
          }
          return Column(children: [
            Row(children: [
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text("Choose your Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))))
            ]),
            Container(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryNames.length,
                    itemBuilder: (BuildContext context, int index) {
                      var currentCategory = categoryNames[index];
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 5, left: 5),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedCategory = currentCategory;
                                  searchText =
                                      ""; // Reset search text when a category is selected
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 211, 211, 211))),
                                  width: 100,
                                  height: 70,
                                  child: Center(
                                      child: Column(children: [
                                    Image.network(
                                      responseData
                                              .firstWhere((food) =>
                                                  food.categoryName ==
                                                  currentCategory)
                                              .image ??
                                          "",
                                      height: 50,
                                      width: 50,
                                    ),
                                    Container(
                                        child: Center(
                                            child: Text(currentCategory)))
                                  ])))));
                    })),
            Row(children: [
              Container(
                  height: 50,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("List of Items",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)))),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Color.fromARGB(255, 188, 203, 210))),
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: SearchField(
                          hint: "Search",
                          suggestions: searchFieldItems,
                          onSearchTextChanged: (String newText) {
                            setState(() {
                              searchText = newText;
                              selectedCategory =
                                  ""; // Reset selected category when searching
                            });
                          })))
            ]),
            Expanded(
                child: Stack(children: [
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 250),
                  itemBuilder: (BuildContext context, int index) {
                    var currentItem = displayedItems[index];
                    return Column(children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: ColorsUsed.borderColor,
                              )),
                              child: Column(children: [
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Container(
                                            width: containerWidth,
                                            height: containerHeight * 0.5,
                                            child: Image.network(
                                                currentItem.image ?? "",
                                                fit: BoxFit.fill, errorBuilder:
                                                    (BuildContext context,
                                                        Object error,
                                                        StackTrace?
                                                            stackTrace) {
                                              return Container(
                                                  color: Colors.grey,
                                                  child: Center(
                                                      child:
                                                          Icon(Icons.error)));
                                            })))),
                                Text(currentItem.productName ?? "Default",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Price ${currentItem.price}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          ColorsUsed
                                                              .buttonColor)),
                                              onPressed: () {
                                                selectedIndices
                                                    .add(currentItem.id!);
                                                List<Map<String, dynamic>>
                                                    itemsToAdd = [
                                                  {
                                                    "id": currentItem.id,
                                                    "isTakeAway": currentItem
                                                        .isTakeAwayActive
                                                  }
                                                ];

                                                Provider.of<ProviderClass>(
                                                  context,
                                                  listen: false,
                                                ).addtoCart(
                                                    itemsToAdd: itemsToAdd);
                                              },
                                              child: Text("Dine In"))),
                                      Spacer(),
                                      Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          ColorsUsed
                                                              .buttonColor)),
                                              onPressed: () {
                                                currentItem.isTakeAwayActive =
                                                    true;
                                                Provider.of<ProviderClass>(
                                                        context,
                                                        listen: false)
                                                    .updateTabChoice(
                                                        isDineIn: false);
                                                selectedIndices
                                                    .add(currentItem.id!);
                                                List<Map<String, dynamic>>
                                                    itemsToAdd = [
                                                  {
                                                    "id": currentItem.id,
                                                    "isTakeAway": currentItem
                                                        .isTakeAwayActive
                                                  }
                                                ];
                                                Provider.of<ProviderClass>(
                                                  context,
                                                  listen: false,
                                                ).addtoCart(
                                                    itemsToAdd: itemsToAdd);
                                              },
                                              child: Text("Take Away")))
                                    ])
                              ])))
                    ]);
                  },
                  itemCount: displayedItems.length)
            ]))
          ]);
        }));
  }
}
