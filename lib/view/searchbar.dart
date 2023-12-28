import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/provider.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/customeSearch.dart';
import 'package:provider/provider.dart';

List<String>? categoryList;

class CustomSearchBar extends StatefulWidget {
  final void Function(String) onQueryChanged;
  final List<String> categoryList;

  CustomSearchBar({required this.onQueryChanged, required this.categoryList});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    print("items inside the categoryList are : ${categoryList}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              onTap: () async {
                await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              onChanged: widget.onQueryChanged,
              decoration: InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(width: 8),
          // Display the selected category in the row
          Text(selectedCategory),
        ],
      ),
    );
  }

  void showCategoryDropdown() {
    DropdownMenu(
      dropdownMenuEntries: [DropdownMenuEntry(value: 1, label: "ashna")],
    );
  }
}
