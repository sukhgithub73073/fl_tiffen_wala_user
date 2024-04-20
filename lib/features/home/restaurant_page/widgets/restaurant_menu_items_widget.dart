import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/models/restaurant_model.dart';
import 'package:tiffen_wala_user/features/home/restaurant_page/widgets/food_item_widget.dart';

class RestaurantMenuItemsWidget extends StatelessWidget {
  final List<Product> products ;
  RestaurantMenuItemsWidget({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return FoodItemWidget(
          imageUrl: products[index].image,
          name: products[index].itemName,
          rating: products[index].rating,
          totalRatings: products[index].ratingCount,
          price: products[index].price,
          isVeg: products[index].type == "Veg",
          isCustomisable: true,
        );
      },
    );
  }
}
