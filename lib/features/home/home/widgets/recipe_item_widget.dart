import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';

class RecipeItemWidget extends StatelessWidget {
  final String recipeName;
  final String recipeImage;
  final VoidCallback? onClick;
  final bool isSelected;
  final IconData? icon;

  const RecipeItemWidget({
    Key? key,
    required this.recipeName,
    required this.recipeImage,
    this.onClick,
    this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onClick != null
        ? withGestureDetector(getItem(context))
        : getItem(context);
  }

  Widget withGestureDetector(Widget widget) => GestureDetector(
        onTap: onClick,
        child: widget,
      );

  Widget getItem(BuildContext context) => Column(
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 50,
                )
              : Image.asset(
                  recipeImage,
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
          const SizedBox(
            height: 7,
          ),
          Text(
            recipeName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? darkBlack : grey,
                  fontSize: 14,
                ),
          ),
        ],
      );
}
