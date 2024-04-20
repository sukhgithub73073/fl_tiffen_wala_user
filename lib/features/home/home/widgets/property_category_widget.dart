import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/models/category_model.dart';

class CategoryItemWidget extends StatelessWidget {
 final CategoryModel categoryModel ;


  const CategoryItemWidget({
    Key? key,
    required this.categoryModel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
      margin: EdgeInsets.only(right: 10),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: categoryModel.isSelected ? primaryColor : Colors.white30,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.1),
            spreadRadius: .5,
            blurRadius: .5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            categoryModel.icon,
            size: 25,
            color: categoryModel.isSelected ? Colors.white : Colors.black,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(
              categoryModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: categoryModel.isSelected ?  FontWeight.bold:FontWeight.normal,
                color: categoryModel.isSelected ? Colors.white : darker,
              ),
            ),
          ),
        ],
      ),
    );  }



}
