// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

ModelClass modelClassFromJson(String str) =>
    ModelClass.fromJson(json.decode(str));

String modelClassToJson(ModelClass data) => json.encode(data.toJson());

class ModelClass {
  List<Food>? food;

  ModelClass({
    this.food,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
        food: json["food"] == null
            ? []
            : List<Food>.from(json["food"]!.map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "food": food == null
            ? []
            : List<dynamic>.from(food!.map((x) => x.toJson())),
      };
}

class Food {
  int? id;
  String? image;
  String? price;
  String? productName;
  String? categoryName;
  int? count;

  Food({
    this.id,
    this.image,
    this.price,
    this.productName,
    this.categoryName,
    this.count = 0,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        image: json["image"],
        price: json["price"],
        productName: json["productName"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "price": price,
        "productName": productName,
        "categoryName": categoryName,
      };
}
