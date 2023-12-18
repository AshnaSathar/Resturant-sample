import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/CategoryList.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:flutter_application_1/view/cart.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/view/invoice.dart';
import 'package:flutter_application_1/widgets/CustomDrawer.dart';
import 'package:flutter_application_1/widgets/CustomeButton.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesPage(),
                        ));
                  },
                  child: Icon(Icons.fastfood)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryList(),
                        ));
                  },
                  child: Icon(Icons.category)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ));
                  },
                  child: Icon(Icons.trolley)),
            ),
          ],
          title: Text(
            "Restaurant",
            style: TextStyle(color: ColorsUsed.text_Color_White),
          ),
          backgroundColor: ColorsUsed.black,
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  "Dine in",
                  style: TextStyle(color: ColorsUsed.text_Color_White),
                ),
              ),
              Tab(
                child: Text(
                  "Take Away",
                  style: TextStyle(color: ColorsUsed.text_Color_White),
                ),
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black.withOpacity(0.6),
          ),
        ),
        drawer: CustomDrawer().getDrawer(context: context),
        body: TabBarView(
          controller: _tabController,
          children: [
            isSendKitchen
                ? Invoice()
                : Container(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome back!"),
                      Text("  "),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesPage(),
                              ));
                        },
                        child: Text(
                          "START",
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                      )
                    ],
                  )),

            // Content for Dine In tab
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome back!"),
                Text("  "),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesPage(),
                        ));
                  },
                  child: Text(
                    "START",
                    style: TextStyle(color: Colors.blue[800]),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
