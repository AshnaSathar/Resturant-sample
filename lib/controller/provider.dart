import 'dart:convert';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:http/http.dart' as http;

int tableIndex = 0;

class ProviderClass with ChangeNotifier {
  ModelClass? responseData;
  List<String> selectedIds = [];
  List<Food> selectedItems = [];

  double totalSum = 0;

  Future<void> fetchData() async {
    try {
      final url =
          Uri.parse('https://mocki.io/v1/02af12fd-41ad-42f6-9137-b405e0c1d8df');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        responseData = ModelClass.fromJson(jsonDecode(response.body));
        selectedIds = List<String>.filled(
          responseData?.food?.length ?? 0,
          "",
        );
        notifyListeners();
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  void addtoCart({required List<int> ids}) {
    print("invoked");
    print("id inside the provider class-addtocart $ids");
    List<Food>? allItems = responseData?.food;

    for (int i = 0; i < ids.length; i++) {
      bool itemExists = selectedItems.any((item) => item.id == ids[i]);

      if (!itemExists) {
        print("verified");
        selectedItems.addAll(
          allItems
                  ?.where(
                    (item) => ids[i] == item.id,
                  )
                  .toList() ??
              [],
        );
        print("the item inside ur addto cart");
        print(selectedItems.map((item) => item.productName));
      }
    }

    notifyListeners();
  }

  Future<void> increment(
      {required int index, required currentCount, required priceofItem}) async {
    print("currentCount=$currentCount");
    selectedItems[index].count = currentCount + 1;

    double priceInt = double.parse(priceofItem);
    double incrementSum = 1 * priceInt;

    totalSum += incrementSum;
    print("Total Sum: $totalSum");

    notifyListeners();
  }

  Future<void> decrement(
      {required int index, required currentCount, required priceofItem}) async {
    if (currentCount >= 0) {
      selectedItems[index].count = currentCount - 1;

      double priceInt = double.parse(priceofItem);
      double decrementSum = 1 * priceInt;

      totalSum -= decrementSum;
      print("Total Sum: $totalSum");

      notifyListeners();
    }
  }

  void removeFromcart(
      {required index, required currentCount, required priceofItem}) {
    totalPriceSub(
        index: index, currentCount: currentCount, priceofItem: priceofItem);
    selectedItems.removeAt(index);

    notifyListeners();
  }

  void totalPriceSub(
      {required int index, required currentCount, required priceofItem}) {
    var amount = selectedItems[index].count;
    double priceInt = double.parse(priceofItem);
    double decrementSum = amount! * priceInt;

    totalSum -= decrementSum;
    print("Total Sum: $totalSum");

    notifyListeners();
  }

  void tableIndexOn({required index}) {
    isSelectedTable[index] = true;
    tableIndex = index;
  }

  void tableIndexOff({required index}) {
    isSelectedTable[index] = false;
  }
}
