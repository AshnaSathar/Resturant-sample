import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/widgets/CustomDrawer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:material_dialogs/material_dialogs.dart';

int i = 1001;

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
    var selectedtable = Provider.of<ProviderClass>(context).selectedTableIndex;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                backgroundColor: ColorsUsed.ButtonPrimaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoriesPage()));
                },
                child: Text("Add")),
            appBar: AppBar(
                actions: [],
                title: Text("Resturant Table: ${selectedtable + 1}",
                    style: TextStyle(color: ColorsUsed.text_Color_White)),
                backgroundColor: ColorsUsed.black,
                bottom: TabBar(
                    indicatorColor: Colors.white,
                    controller: tabController,
                    tabs: [
                      Tab(
                          child: Text("Dine- in",
                              style: TextStyle(
                                  color: ColorsUsed.text_Color_White))),
                      Tab(
                          child: Text("Take Away",
                              style: TextStyle(
                                  color: ColorsUsed.text_Color_White)))
                    ],
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black.withOpacity(0.6))),
            drawer: CustomDrawer().getDrawer(context: context),
            body: TabBarView(controller: tabController, children: [
              // Dine In Content
              buildTabContent(isDineIn: true),
              // Take Away Content
              buildTabContent(isDineIn: false)
            ])));
  }

  Widget buildTabContent({required bool isDineIn}) {
    var provider = Provider.of<ProviderClass>(context);
    var selectedTableIndex = provider.selectedTableIndex;
    var orderMap = provider.orderMap;
    var selectedTable = provider.selectedTableIndex;
    if (orderMap[selectedTableIndex] == null ||
        orderMap[selectedTableIndex]!.isEmpty) {
      return Center(
        child: Text("Welcome! Your cart is empty."),
      );
    }

    var selectedItems = isDineIn
        ? orderMap[selectedTableIndex]!['dineIn']
        : orderMap[selectedTableIndex]!['takeAway'];

    return Column(children: [
      DataTable(
          columns: [
            DataColumn(
                label: Text('Si.No',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Name',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Price',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Count',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Type',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Total',
                    style: TextStyle(fontWeight: FontWeight.bold)))
          ],
          rows: (selectedItems ?? []).map((currentItem) {
            i++;
            return DataRow(cells: [
              DataCell(Text("$i" ?? "Default")),
              DataCell(Text(currentItem.productName ?? "Default")),
              DataCell(Text(currentItem.price ?? "Default")),
              DataCell(Text((currentItem.count).toString())),
              DataCell(Text(isDineIn ? 'DineIn' : 'TakeAway')),
              DataCell(Text((double.parse(currentItem.price ?? "0.0") *
                      (currentItem.count ?? 0))
                  .toStringAsFixed(2)))
            ]);
          }).toList()),
      Spacer(),
      BottomAppBar(
        child: Row(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Total Cost: ${Provider.of<ProviderClass>(context).totalSumForTable[selectedTable]}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(ColorsUsed.buttonColor),
              ),
              onPressed: () {
                Dialogs.materialDialog(
                    color: Colors.white,
                    title: 'Order Completed Successfully',
                    lottieBuilder: Lottie.asset(
                        'assets/Animation - 1702544292158.json',
                        fit: BoxFit.contain),
                    context: context,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TablesPage(),
                                ));
                          },
                          icon: Icon(Icons.close))
                    ]);

                isSelectedTable[selectedTableIndex] = false;

                Provider.of<ProviderClass>(context, listen: false)
                    .clearCartForTable(tableIndex: selectedTableIndex);
                setState(() {});
              },
              child: Text("Complete"))
        ]),
      ),
    ]);
  }
}
