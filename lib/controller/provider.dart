import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:http/http.dart' as http;

int tableIndex = 0;

class ProviderClass with ChangeNotifier {
  ModelClass? responseData;
  List<String> selectedIds = [];
  List<Food> selectedItems = [];
  var count = 0;
  var currentCount;
  double totalSum = 0;
  double sum = 0;
  double? currentPrice;
  Future<void> fetchData() async {
    try {
      final url =
          Uri.parse('https://mocki.io/v1/02af12fd-41ad-42f6-9137-b405e0c1d8df');
      var response = await http.get(url);
      // print("Response Status Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        responseData = ModelClass.fromJson(jsonDecode(response.body));
        // print(responseData);
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

  Future<void> addtoCart({required List<int> ids}) async {
    List<Food>? allItems = responseData?.food;

    for (int i = 0; i < ids.length; i++) {
      bool itemExists = selectedItems.any((item) => item.id == ids[i]);

      if (!itemExists) {
        selectedItems.addAll(
          allItems
                  ?.where(
                    (item) => ids[i] == item.id,
                  )
                  .toList() ??
              [],
        );
      }
    }

    notifyListeners();
  }

  Future increment(
      {required int index, required currentCount, required priceofItem}) async {
    selectedItems[index].count = currentCount + 1;

    double priceInt = double.parse(priceofItem);
    sum = 1 * priceInt;

    totalSum = totalSum + sum;
    print(" ${totalSum}");

    notifyListeners();
  }

  Future decrement(
      {required int index, required currentCount, required priceofItem}) async {
    if (currentCount >= 0) {
      selectedItems[index].count = currentCount - 1;
    }

    double priceInt = double.parse(priceofItem);
    sum = 1 * priceInt;

    totalSum = totalSum - sum;
    print(" ${totalSum}");
    notifyListeners();
  }

  Future removeFromcart(
      {required index, required currentCount, required priceofItem}) async {
    totalPriceSub(
        index: index, currentCount: currentCount, priceofItem: priceofItem);
    selectedItems.removeAt(index);

    notifyListeners();
  }

  Future totalPriceSub(
      {required int index, required currentCount, required priceofItem}) async {
    var amount = selectedItems[index].count;
    double priceInt = double.parse(priceofItem);
    sum = amount! * priceInt;

    totalSum = totalSum - sum;
    print(" ${totalSum}");
    notifyListeners();
  }

  Future tableIndexOn({required index}) async {
    isSelectedTable[index] = true;
    tableIndex = index;
  }

  Future tableIndexOff({required index}) async {
    isSelectedTable[index] = false;
  }
}
