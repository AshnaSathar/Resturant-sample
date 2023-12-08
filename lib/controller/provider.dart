import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:http/http.dart' as http;

class ProviderClass with ChangeNotifier {
  ModelClass? responseData;
  Future fetchData() async {
    final url =
        Uri.parse('https://mocki.io/v1/02af12fd-41ad-42f6-9137-b405e0c1d8df');
    var response = await http.get(url);
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");
    responseData = ModelClass.fromJson(jsonDecode(response.body));
    print(responseData);
    notifyListeners();
  }
}
