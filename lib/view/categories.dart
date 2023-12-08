import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var containerHeight = MediaQuery.of(context).size.height * 0.2;
    var containerWidth = MediaQuery.of(context).size.width * 0.3;
    CustomAppBar appBarObject = CustomAppBar();

    return Scaffold(
      appBar: appBarObject.getAppBar(title: "Categories"),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: containerHeight,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsUsed.borderColor)),
                child: Column(
                  children: [
                    Container(
                      height: containerHeight * .5,
                      color: Colors.green,
                      child: Image.network(
                          Provider.of<ProviderClass>(context, listen: false)
                                  .responseData
                                  ?.image ??
                              ""),
                    ),
                    Text(Provider.of<ProviderClass>(context, listen: false)
                            .responseData
                            ?.categoryName
                            .toString() ??
                        "hey"),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            maxRadius: 15,
                            backgroundColor: Colors.black,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  print("");
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            maxRadius: 15,
                            backgroundColor: Colors.black,
                            child: InkWell(
                                onTap: () {}, child: Icon(Icons.remove)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        },
        itemCount: 26,
      ),
    );
  }
}
