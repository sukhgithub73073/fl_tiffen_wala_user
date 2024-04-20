import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';

class VegOrNonVegIconWidget extends StatelessWidget {
  final bool isVeg;
  final double size;

  const VegOrNonVegIconWidget({
    Key? key,
    this.size = 20,
    this.isVeg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(color: isVeg ? greenColor : deepChestnut, width: 1.5)),
      child: isVeg
          ? Icon(
              Icons.circle,
              color: greenColor,
              size: 0.55 * size,
            )
          : Image.asset(
              "assets/images/non_veg_icon.png",
              color: deepChestnut,
              height: 0.6 * size,
              width: 0.6 * size,
            ),
    );
  }
}
