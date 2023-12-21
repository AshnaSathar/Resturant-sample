import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/Cart_pages/cart.dart';
import 'package:flutter_application_1/view/Table.dart';
import 'package:http/http.dart' as http;

int tableIndex = 0;
List<int> disabledIds = [];

class ProviderClass with ChangeNotifier {
  ModelClass? responseData;
  List<String> selectedIds = [];
  List<Food> selectedItems = [];
  List<String> selectedIdForDineIn = [];
  List<Food> selectedItemsForDineIn = [];
  List<String> selectedIdForTakeAway = [];
  List<Food> selectedItemsForTakeAway = [];
  double totalSum = 0;
  List<int> idtoDisable = [];
  List<int> sharedDisabledIds = [];
  bool? tabchoice;
  bool? isTakeAwayActive;

  set isSendKitchen(bool isSendKitchen) {}

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

  // void addtoCart({required List<int?> ids}) {
  //   List<Food>? allItems = responseData?.food;
  //   List<Food> selectedItemsList =
  //       tabchoice! ? selectedItemsForDineIn : selectedItemsForTakeAway;
  //   for (int? id in ids) {
  //     if (id != null) {
  //       bool itemExists = selectedItemsList.any((item) => item.id == id);

  //       if (!itemExists) {
  //         var newItem = allItems?.firstWhere((item) => id == item.id,
  //             orElse: () => Food());

  //         newItem?.isEnabled = !sharedDisabledIds.contains(id);

  //         selectedItemsList.add(newItem ?? Food());

  //         sharedDisabledIds.add(id);
  //       }
  //     }
  //   }

  //   notifyListeners();

  void addtoCart({required List<Map<dynamic, dynamic>> itemsToAdd}) {
    print(itemsToAdd);
    List<Food>? allItems = responseData?.food;

    for (var itemData in itemsToAdd) {
      int id = itemData['id'] as int;
      bool isTakeAwayActiveValue = itemData['isTakeAway'] as bool;
      print(isTakeAwayActiveValue);
      bool itemExists = selectedItems.any((item) => item.id == id);

      if (!itemExists) {
        var newItem =
            allItems?.firstWhere((item) => id == item.id, orElse: () => Food());

        newItem?.isEnabled = !sharedDisabledIds.contains(id);
        selectedItems.add(newItem ?? Food());

        sharedDisabledIds.add(id);

        if (isTakeAwayActiveValue) {
          print("inside second if");
          print("selected item for dine-in: ${selectedItemsForTakeAway}");
          selectedItemsForTakeAway.add(newItem!);
        } else {
          print("selected item for take away are: ${selectedItemsForDineIn}");
          selectedItemsForDineIn.add(newItem!);
        }
        for (var i = 0; i < selectedItemsForTakeAway.length; i++) {
          print("items are ${selectedItemsForTakeAway[i].productName}");
        }
      }
    }

    notifyListeners();
  }

  void updateTabChoice({required bool isDineIn}) {
    tabchoice = isTakeAwayActive;
    notifyListeners();
  }

  Future<void> increment(
      {required int index, required currentCount, required priceofItem}) async {
    print("inside increment");
    selectedItems =
        tabchoice! ? selectedItemsForDineIn : selectedItemsForTakeAway;
    selectedItems[index].count = currentCount + 1;

    double priceInt = double.parse(priceofItem);
    double incrementSum = 1 * priceInt;

    totalSum += incrementSum;
    print("Total Sum: $totalSum");
    // tofindTotal();
    notifyListeners();
  }

  Future<void> decrement(
      {required int index, required currentCount, required priceofItem}) async {
    selectedItems =
        tabchoice! ? selectedItemsForDineIn : selectedItemsForTakeAway;

    if (currentCount! > 0) {
      selectedItems[index].count = currentCount - 1;
      double priceInt = double.parse(priceofItem);
      double decrementSum = 1 * priceInt;
      totalSum -= decrementSum;
      print("Total Sum: $totalSum");

      // tofindTotal();
      notifyListeners();
    }
  }

  void removeFromcart(
      {required index, required currentCount, required priceofItem}) {
    print('invoking');
    selectedItems =
        tabchoice! ? selectedItemsForDineIn : selectedItemsForTakeAway;
    // tofindTotal();

    selectedItemsForDineIn.removeAt(index);
    notifyListeners();
  }

  void totalPriceSub(
      {required int index, required currentCount, required priceofItem}) {
    var amount = currentCount;
    print("current count is $currentCount");
    double priceInt =
        double.tryParse(selectedItemsForDineIn[index].price!) ?? 0.0;
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

  void disableButton({required var id}) {
    idtoDisable.add(id);
    sharedDisabledIds.add(id);

    for (int i = 0; i < selectedItems.length; i++) {
      if (selectedItems[i].id == id) {
        selectedItems[i].isEnabled = false;
        break;
      }
    }

    notifyListeners();
  }
}
