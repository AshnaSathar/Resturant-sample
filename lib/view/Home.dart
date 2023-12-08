import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/utils/globalObjects.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:flutter_application_1/widgets/CustomeButton.dart';

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

  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var containerHeight = MediaQuery.of(context).size.height * 0.5;
    var containerWidth = MediaQuery.of(context).size.width * 0.5;
    List faq_container_content = ["TAke away", "Dine-In"];
    CustomAppBar appBarObject = CustomAppBar();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Resturant",
              style: TextStyle(color: ColorsUsed.text_Color_White),
            ),
            backgroundColor: ColorsUsed.black,
            bottom: TabBar(
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(
                  child: Text(
                    "Take Away",
                    style: TextStyle(color: ColorsUsed.text_Color_White),
                  ),
                ),
                Tab(
                  child: Text(
                    "Dine in",
                    style: TextStyle(color: ColorsUsed.text_Color_White),
                  ),
                ),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Container(
                height: screenHeight,
                child: Center(
                  child: Container(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesPage(),
                              ));
                        },
                        child: ButtonWidget(title: "Add Items")),
                  ),
                ),
                // child: Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       child: Icon(Icons.add),
                //     ),
                //   ],
                // ),
              ),

              // Content for Dine In tab
              Container(
                child: Center(
                  child: Text("Dine In Content"),
                ),
              ),
            ],
          ),
        ));
  }
}
