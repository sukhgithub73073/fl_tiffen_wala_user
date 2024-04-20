// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
  String id;
  String poster;
  String name;
  String onwerName;
  String mobile;
  String email;
  String radius;
  String address;
  List<Offer> offers;
  List<Category> category;

  RestaurantModel({
    required this.id,
    required this.poster,
    required this.name,
    required this.onwerName,
    required this.mobile,
    required this.email,
    required this.radius,
    required this.address,
    required this.offers,
    required this.category,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    id: json["id"]??"",
    poster: json["poster"],
    name: json["name"],
    onwerName: json["onwer_name"],
    mobile: json["mobile"],
    email: json["email"],
    radius: json["radius"],
    address: json["address"],
    offers: List<Offer>.from((json["offers"]??[]).map((x) => Offer.fromJson(x))),
    category: List<Category>.from((json["category"]??[]).map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "poster": poster,
    "name": name,
    "onwer_name": onwerName,
    "mobile": mobile,
    "email": email,
    "radius": radius,
    "address": address,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String name;
  List<Product> products;

  Category({
    required this.id,
    required this.name,
    required this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String id;
  String type;
  String itemName;
  double rating;
  int ratingCount;
  int price;
  String tag;
  String image;

  Product({
    required this.id,
    required this.type,
    required this.itemName,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.tag,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    type: json["type"],
    itemName: json["item_name"],
    rating: json["rating"]?.toDouble(),
    ratingCount: json["rating_count"],
    price: json["price"],
    tag: json["tag"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "item_name": itemName,
    "rating": rating,
    "rating_count": ratingCount,
    "price": price,
    "tag": tag,
    "image": image,
  };
}

class Offer {
  String id;
  String title;
  String description;

  Offer({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
  };
}
