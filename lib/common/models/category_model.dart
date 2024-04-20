import 'package:flutter/cupertino.dart';

class CategoryModel {
  String name;

  IconData icon;

  bool isSelected;

  CategoryModel(
      {required this.name, required this.icon, required this.isSelected});
}
