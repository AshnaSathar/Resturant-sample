import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:flutter_application_1/view/categories.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import '../widgets/TableWIdget.dart';

class TablesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    CustomAppBar appBarObject = CustomAppBar();

    return Scaffold(
      backgroundColor: ColorsUsed.backgroundColor,
      appBar: appBarObject.getAppBar(
        title: "Table",
      ),
      body: Consumer<ProviderClass>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: screenHeight,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onDoubleTap: () {
                          isSelectedTable[index] = false;
                        },
                        onTap: () {
                          // print("the index is $index");
                          // print('Table tapped: $index');
                          Provider.of<ProviderClass>(context, listen: false)
                              .selectedTableIndexfunc(tableIndex: index);
                          // Provider.of<ProviderClass>(context, listen: false)
                          //     .addToTableOrder(
                          //         tableNumber: index, isTakeAwayActive: false);
                          Provider.of<ProviderClass>(context, listen: false)
                              .tableIndexOn(index: index);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: CustomTableWidget(tableindex: index),
                      );
                    },
                    itemCount: 8,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
