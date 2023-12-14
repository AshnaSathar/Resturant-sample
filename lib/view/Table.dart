import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import '../widgets/TableWIdget.dart';

List<bool> isSelectedTable = List.generate(100, (index) => false);

class TablesPage extends StatefulWidget {
  const TablesPage({Key? key}) : super(key: key);

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    CustomAppBar appBarObject = CustomAppBar();

    return Scaffold(
      appBar: appBarObject.getAppBar(
        title: "Table",
      ),
      body: SingleChildScrollView(
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
                      setState(() {});
                    },
                    onTap: () {
                      Provider.of<ProviderClass>(context, listen: false)
                          .tableIndexOn(index: index);
                      setState(() {});
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                      print('Tapped on container $index');
                    },
                    child: CustomTableWidget(index: index),
                  );
                },
                itemCount: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
