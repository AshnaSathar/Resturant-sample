import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/Cart_pages/cartDineIn.dart';

import 'package:flutter_application_1/view/categories.dart';
import 'package:http/http.dart' as http;

List<int> disabledIds = [];

class ProviderClass with ChangeNotifier {
  // var takeActiveindexTopass;
  int tableIndex = 0;
  ModelClass? responseData;
  int selectedTableIndex = 0;
  List<String> selectedIds = [];
  List<Food> selectedItems = [];
  List<String> selectedItemsForDineIn_temperory = [];
  List<Food> selectedItemsForDineIn = [];
  List<String> selectedIdForTakeAway = [];
  List<Food> selectedItemsForTakeAway = [];
  bool? tabchoice;
  double totalSum = 0;
  List<int> idtoDisable = [];
  List<int> sharedDisabledIds = [];
  List activeTableList = [];
  bool? isTakeAwayActive;
  var totalPriceForDineIn;
  var totalPriceForTakeAway;
  var items = [];
  Map<int, Map<String, List<Food>>> cartMap = {};
  var sample;
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

  void addtoCart({required List<Map<String, dynamic>> itemsToAdd}) {
    cartMap[selectedTableIndex] ??= {'dineIn': [], 'takeAway': []};

    List<Food>? allItems = responseData?.food;

    Set<int> dineInItemIds = Set<int>.from(
        cartMap[selectedTableIndex]!['dineIn']!.map((item) => item.id));
    Set<int> takeAwayItemIds = Set<int>.from(
        cartMap[selectedTableIndex]!['takeAway']!.map((item) => item.id));

    for (var itemData in itemsToAdd) {
      int id = itemData['id'] as int;
      bool isTakeAwayActiveValue = itemData['isTakeAway'] as bool;

      bool itemExists = isTakeAwayActiveValue
          ? takeAwayItemIds.contains(id)
          : dineInItemIds.contains(id);

      if (!itemExists) {
        var newItem =
            allItems?.firstWhere((item) => item.id == id, orElse: () => Food());

        if (newItem != null) {
          newItem.isEnabled = !sharedDisabledIds.contains(id);

          if (isTakeAwayActiveValue) {
            cartMap[selectedTableIndex]!['takeAway']!.add(newItem);
            takeAwayItemIds.add(id);
          } else {
            cartMap[selectedTableIndex]!['dineIn']!.add(newItem);
            dineInItemIds.add(id);
          }
        }
      }
    }
  }

  void selectedTableIndexfunc({required tableIndex}) {
    selectedTableIndex = tableIndex;
    // print(selectedTableIndex);
    if (!activeTableList.contains(selectedTableIndex)) {
      activeTableList.add(selectedTableIndex);
    }
    // print(activeTableList);
    notifyListeners();
  }

  void removeTableFromActiveTable({required index}) {
    if (activeTableList.contains(index)) {
      activeTableList.remove(index);
    }
  }

  void updateTabChoice({required bool isDineIn}) {
    tabchoice = isTakeAwayActive;

    notifyListeners();
  }

  Future<void> increment({
    required int id,
    required int currentCount,
    required dynamic priceofItem,
    required bool isTakeAwayActive,
  }) async {
    cartMap[selectedTableIndex] ??= {'dineIn': [], 'takeAway': []};
    ("inside increment");
    // print("isTakeAway=$isTakeAwayActive");

    List<Food> selectedItemList = isTakeAwayActive
        ? cartMap[selectedTableIndex]!['takeAway']!
        : cartMap[selectedTableIndex]!['dineIn']!;

    var selectedItem = selectedItemList.firstWhere((item) => item.id == id);

    var updatedItem = Food(
      id: selectedItem.id,
      productName: selectedItem.productName,
      price: selectedItem.price,
      count: currentCount + 1,
      isTakeAwayActive: selectedItem.isTakeAwayActive,
    );

    int index = selectedItemList.indexOf(selectedItem);
    selectedItemList[index] = updatedItem;

    double priceInt = double.parse(priceofItem.toString());
    double incrementSum = 1 * priceInt;

    totalSum += incrementSum;
    // print("Total Sum: $totalSum");

    notifyListeners();
  }

  Future<void> decrement({
    required int id,
    required int currentCount,
    required dynamic priceofItem,
    required bool isTakeAwayActive,
  }) async {
    cartMap[selectedTableIndex] ??= {'dineIn': [], 'takeAway': []};
    // print("inside increment");
    // print("isTakeAway=$isTakeAwayActive");

    List<Food> selectedItemList = isTakeAwayActive
        ? cartMap[selectedTableIndex]!['takeAway']!
        : cartMap[selectedTableIndex]!['dineIn']!;

    var selectedItem = selectedItemList.firstWhere((item) => item.id == id);

    var updatedItem = Food(
      id: selectedItem.id,
      productName: selectedItem.productName,
      price: selectedItem.price,
      count: currentCount - 1,
      isTakeAwayActive: selectedItem.isTakeAwayActive,
    );

    int index = selectedItemList.indexOf(selectedItem);
    selectedItemList[index] = updatedItem;

    double priceInt = double.parse(priceofItem.toString());
    double incrementSum = 1 * priceInt;

    totalSum -= incrementSum;
    // print("Total Sum: $totalSum");

    notifyListeners();
  }

  // void removeFromcart({
  //   required id,
  //   required isTakeAwayActive,
  //   required int currentCount,
  //   required double priceofItem,
  // }) {
  //   print(id);
  //   List<Food> selectedItemList = isTakeAwayActive
  //       ? cartMap[selectedTableIndex]!['takeAway']!
  //       : cartMap[selectedTableIndex]!['dineIn']!;

  //   var selectedItem = selectedItemList.firstWhere((item) => item.id == id);

  //   isTakeAwayActive
  //       ? cartMap[selectedTableIndex]!['takeAway']!.removeWhere(id)
  //       : cartMap[selectedTableIndex]!['dineIn']!.removeWhere(id);
  //   // selectedItemList

  //   var amount;
  //   amount = priceofItem * currentCount;
  //   selectedItem.count = 0;

  //   totalSum = totalSum - amount;
  //   notifyListeners();
  // }

  // int findIndexById(int id, List<Food> items) {
  //   for (int i = 0; i < items.length; i++) {
  //     if (items[i].id == id) {
  //       return i;
  //     }
  //   }
  //   return -1;
  // }
  void removefromCartTakeAway({required int id}) {
    cartMap[selectedTableIndex]!['takeAway']!
        .removeWhere((item) => item.id == id);

    notifyListeners();
  }

  void tableIndexOn({required index}) {
    isSelectedTable[index] = true;
    tableIndex = index;
  }

  // void tableIndexOff({required index}) {
  //   isSelectedTable[index] = false;
  // }

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

  void removefromCart({required int id}) {
    if (cartMap.containsKey(selectedTableIndex) &&
        cartMap[selectedTableIndex]!.containsKey('dineIn')) {
      // var selecteditemis = cartMap[selectedTableIndex]!['dineIn']!
      //     .where((element) => element.id == id);

      // print(selecteditemis);
      cartMap[selectedTableIndex]!['dineIn']!
          .removeWhere((item) => item.id == id);
    }

    notifyListeners();
  }
}
