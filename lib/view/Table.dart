import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';
import 'package:flutter_application_1/view/Home.dart';
import 'package:flutter_application_1/widgets/CustomAppBar.dart';
import '../widgets/TableWIdget.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({Key? key}) : super(key: key);

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  @override
  Widget build(BuildContext context) {
    int i = 0;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var containerHeight = MediaQuery.of(context).size.height * 0.5;
    var containerWidth = MediaQuery.of(context).size.width * 0.5;
    CustomAppBar appBarObject = CustomAppBar();

    return Scaffold(
      appBar: appBarObject.getAppBar(title: ""),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: screenHeight,
              color: ColorsUsed.black,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  i++;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                      print('Tapped on container $index');
                    },
                    child: CustomTableWidget(index: i),
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
