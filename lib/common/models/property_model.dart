// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  String title;
  String description;
  int area;
  int price;
  String address;
  double latitude;
  double longitude;
  String furnishing;
  int bedrooms;
  int bathrooms;
  String leaseType;
  String parking;
  bool gasPipeline;
  List<ImagesList> imagesList ;

  PropertyModel({
    required this.title,
    required this.description,
    required this.area,
    required this.price,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.furnishing,
    required this.bedrooms,
    required this.bathrooms,
    required this.leaseType,
    required this.parking,
    required this.gasPipeline,
    required this.imagesList,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) =>
      PropertyModel(
        title: json["title"],
        description: json["description"],
        area: json["area"],
        price: json["price"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        furnishing: json["furnishing"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        leaseType: json["lease_type"],
        parking: json["parking"],
        gasPipeline: json["gas_pipeline"],
        imagesList: List<ImagesList>.from(
            json["imagesList"].map((x) => ImagesList.fromJson(x))),

      );

  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "description": description,
        "area": area,
        "price": price,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "furnishing": furnishing,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "lease_type": leaseType,
        "parking": parking,
        "gas_pipeline": gasPipeline,
        "imagesList": List<dynamic>.from(imagesList.map((x) => x.toJson())),

      };
}

class ImagesList {
  String url;

  ImagesList({
    required this.url,
  });

  factory ImagesList.fromJson(Map<String, dynamic> json) =>
      ImagesList(
        url: json["url"],
      );

  Map<String, dynamic> toJson() =>
      {
        "url": url,
      };
}