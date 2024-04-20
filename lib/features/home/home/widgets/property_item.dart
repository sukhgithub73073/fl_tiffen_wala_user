import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/models/pair.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';
import 'package:tiffen_wala_user/common/widgets/custom_dashed_divider.dart';
import 'package:tiffen_wala_user/common/widgets/delivery_time_and_distance_widget.dart';
import 'package:tiffen_wala_user/common/widgets/discount_widget.dart';
import 'package:tiffen_wala_user/common/widgets/property_name_and_price_widget.dart';
import 'package:tiffen_wala_user/common/widgets/restaurant_name_and_rating_widget.dart';

class PropertyItemWidget extends StatelessWidget {
  final PropertyModel propertyModel;

  const PropertyItemWidget({
    Key? key,
    required this.propertyModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  propertyModel.imagesList.isNotEmpty
                      ? propertyModel.imagesList.first.url
                      : "https://housing-images.n7net.in/01c16c28/045cf6537464d1820dfd867538b1ef21/v0/fs-large/2_bhk_apartment-for-rent-aujala-Mohali-hall.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0).copyWith(left: 12),
              child: Column(
                children: [
                  PropertyNameAndPriceWidget(
                      restaurantName: propertyModel.title,
                      price: propertyModel.price),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      propertyModel.description,
                      maxLines: 1,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        color: grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                  DeliveryTimeAndDistanceWidget(
                      deliveryTime: Pair(10, 65), distance: 36),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
