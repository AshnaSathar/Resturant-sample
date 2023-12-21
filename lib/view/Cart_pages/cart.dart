import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';

import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Cart_pages/cartDineIn.dart';
import 'package:flutter_application_1/view/Cart_pages/cartTakeAway.dart';

import 'package:flutter_application_1/view/categories.dart';

import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

var currentCount = 1;

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Cart"),
        leading: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(ColorsUsed.buttonColor),
          ),
          onPressed: () {
            print(
                "${Provider.of<ProviderClass>(context, listen: false).selectedIds}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CategoriesPage(),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: tabController,
          tabs: [
            Tab(text: "Dine In cart"),
            Tab(text: "Take Away cart"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildTabContent(isDineIn: true),
          buildTabContent(isDineIn: false),
        ],
      ),
    );
  }

  Widget buildTabContent({required bool isDineIn}) {
    var provider = Provider.of<ProviderClass>(context);

    if (isDineIn) {
      if (provider.selectedItemsForDineIn.isEmpty) {
        return Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * .1,
            child: Lottie.asset('assets/Animation - 1702448401276.json'),
          ),
        );
      } else {
        return CartDineIn();
      }
    } else {
      if (provider.selectedItemsForTakeAway.isEmpty) {
        return Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * .1,
            child: Lottie.asset('assets/Animation - 1702448401276.json'),
          ),
        );
      } else {
        return CartTakeAway();
      }
    }
  }
}
