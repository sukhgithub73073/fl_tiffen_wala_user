import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';


class PropertyNameAndPriceWidget extends StatelessWidget {
  final String restaurantName;
  final int price;
  final double textSize;

  const PropertyNameAndPriceWidget({
    Key? key,
    required this.restaurantName,
    required this.price,
    this.textSize = 17,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            restaurantName,
            maxLines: 1,
            style: textTheme.titleSmall?.copyWith(
              color: darkBlack,
              fontSize: textSize,
            ),
          ),
        ),


        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.5, vertical: 4),
          decoration: BoxDecoration(color: greenColor,borderRadius: BorderRadius.circular(7),),
          child: Text(
            "₹ $price",
            style:
            textTheme.titleSmall?.copyWith(color: white, fontSize: 14),
          ),
        )
      ],
    );
  }
}
