// home.dart

import 'package:flutter/material.dart';

import 'package:flutter_application_1/utils/color_Constants.dart';

import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/widgets/CustomDrawer.dart';
import 'package:flutter_application_1/view/Invoice_Pages/invoice.dart';
import 'package:flutter_application_1/widgets/CustomeButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesPage(),
                ));
          },
          child: Text("Add"),
        ),
        appBar: AppBar(
          actions: [],
          title: Text(
            "Restaurant",
            style: TextStyle(color: ColorsUsed.text_Color_White),
          ),
          backgroundColor: ColorsUsed.black,
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: tabController,
            tabs: [
              GestureDetector(
                // onTap: () {
                //   Provider.of<ProviderClass>(context).tabchoice = true;
                // },
                child: GestureDetector(
                  // onTap: () {
                  //   Provider.of<ProviderClass>(context).tabchoice = false;
                  // },
                  child: Tab(
                    child: Text(
                      "Dine- in",
                      style: TextStyle(color: ColorsUsed.text_Color_White),
                    ),
                  ),
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
          controller: tabController,
          children: [
            // Dine In Content
            buildTabContent(isDineIn: true),

            // Take Away Content
            buildTabContent(isDineIn: false),
          ],
        ),
      ),
    );
  }

  Widget buildTabContent({required bool isDineIn}) {
    if (isDineIn) {
      return isSendKitchenDineIn
          ? Invoice()
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome back Dine In!"),
                  Text("  "),
                  // InkWell(
                  // onTap: () {
                  //   Provider.of<ProviderClass>(context, listen: false)
                  //       .updateTabChoice(true);

                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => CategoriesPage(),
                  //     ),
                  //   );
                  // },
                  // child: Text(
                  //   "START",
                  //   style: TextStyle(color: Colors.blue[800]),
                  // ),
                  // )
                ],
              ),
            );
    } else {
      return isSendKitchenTakeAway
          ? Invoice()
          : Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome back Take Away!"),
                  Text("  "),
                  // InkWell(
                  //   onTap: () {
                  //     Provider.of<ProviderClass>(context, listen: false)
                  //         .updateTabChoice(false);

                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => CategoriesPage(),
                  //       ),
                  //     );
                  //   },
                  //   child: Text(
                  //     "START",
                  //     style: TextStyle(color: Colors.blue[800]),
                  //   ),
                  // )
                ],
              ),
            );
    }
  }
}
