import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/models/category_model.dart';

class specificationItemWidget extends StatelessWidget {
 final CategoryModel categoryModel ;


  const specificationItemWidget({
    Key? key,
    required this.categoryModel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      margin: EdgeInsets.only(right: 10),
      width: 90,
      height: 100,
      decoration: BoxDecoration(
        color:  primaryColor.withOpacity(0.2),
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
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
              color: primaryColor.withOpacity(0.25)

            ),
            child: Icon(
              categoryModel.icon,
              size: 20,
              color: primaryColor,
            ),
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
                fontWeight: FontWeight.normal,
                color: darker.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );  }



}
