// To parse this JSON data, do
//
//     final modelClass = modelClassFromJson(jsonString);

import 'dart:convert';

ModelClass modelClassFromJson(String str) =>
    ModelClass.fromJson(json.decode(str));

String modelClassToJson(ModelClass data) => json.encode(data.toJson());

class ModelClass {
  int? id;
  String? image;
  String? price;
  String? productName;
  String? categoryName;

  ModelClass({
    this.id,
    this.image,
    this.price,
    this.productName,
    this.categoryName,
  });

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
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
