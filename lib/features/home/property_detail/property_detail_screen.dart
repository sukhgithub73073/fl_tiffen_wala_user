import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiffen_wala_user/blocs/message_bloc/message_bloc.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/models/category_model.dart';
import 'package:tiffen_wala_user/common/models/pair.dart';
import 'package:tiffen_wala_user/common/models/property_model.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/common/utils/utils.dart';
import 'package:tiffen_wala_user/common/widgets/app_read_more_text.dart';
import 'package:tiffen_wala_user/common/widgets/app_tap_widget.dart';
import 'package:tiffen_wala_user/common/widgets/delivery_time_and_distance_widget.dart';
import 'package:tiffen_wala_user/common/widgets/property_name_and_price_widget.dart';
import 'package:tiffen_wala_user/features/home/chat_screens/individual_page.dart';
import 'package:tiffen_wala_user/features/home/home/widgets/property_category_widget.dart';
import 'package:tiffen_wala_user/features/home/home/widgets/property_specification_widget.dart';

class PropertyDetailScreen extends StatefulWidget {
  final PropertyModel propertyModel;

  const PropertyDetailScreen({super.key, required this.propertyModel});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  var textTheme;
  var screenWidth = 0.0;

  List<CategoryModel> categoryList = [];

  @override
  void initState() {
    super.initState();

    categoryList = [
      CategoryModel(
          name: "${widget.propertyModel.bedrooms} Bedrooms",
          icon: FontAwesomeIcons.bed,
          isSelected: true),
      CategoryModel(
          name: "${widget.propertyModel.bathrooms} Bathrooms",
          icon: FontAwesomeIcons.bath,
          isSelected: false),
      CategoryModel(
          name: "${widget.propertyModel.area} Sq.ft",
          icon: FontAwesomeIcons.chartArea,
          isSelected: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    screenWidth = MediaQuery.sizeOf(context).width * 0.35;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: TapWidget(
            onTap: () {
              context.back();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          title: Text(
            "${widget.propertyModel.title}",
            style: textTheme?.labelLarge?.copyWith(fontSize: 18.0),
          ),
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.propertyModel.imagesList.isNotEmpty
                      ? widget.propertyModel.imagesList
                          .firstWhere((element) => element.isPrimary)
                          .url
                      : "https://housing-images.n7net.in/01c16c28/045cf6537464d1820dfd867538b1ef21/v0/fs-large/2_bhk_apartment-for-rent-aujala-Mohali-hall.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
                Positioned(
                    right: 20,
                    bottom: 0,
                    top: 0,
                    child: Container(
                      height: 250,
                      width: 60,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.propertyModel.imagesList.length,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TapWidget(
                                onTap: () {
                                  setState(() {
                                    widget.propertyModel.imagesList
                                        .forEach((element) {
                                      element.isPrimary = false;
                                    });
                                    widget.propertyModel.imagesList[i]
                                        .isPrimary = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: widget.propertyModel
                                                  .imagesList[i].isPrimary
                                              ? primaryColor
                                              : midGrey,
                                          width: 2)),
                                  child: Image.network(
                                    widget.propertyModel.imagesList[i].url,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 45,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0).copyWith(left: 12),
              child: Column(
                children: [
                  PropertyNameAndPriceWidget(
                      restaurantName: widget.propertyModel.title,
                      price: widget.propertyModel.price),
                  Row(
                    children: [
                      Text(
                        "${widget.propertyModel.address}",
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 14.0,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DeliveryTimeAndDistanceWidget(
                      deliveryTime: Pair(10, 65), distance: 36),
                  Container(
                    height: 130,
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: ListView.builder(
                        itemCount: categoryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: specificationItemWidget(
                              categoryModel: categoryList[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Description",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: true
                        ? ReadMoreText(
                            '${widget.propertyModel.description}',
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            style: textTheme.bodyLarge?.copyWith(
                              fontSize: 14.0,
                              color: grey.withOpacity(0.8),
                            ),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: ' Show more',
                            trimExpandedText: ' Show less',
                            moreStyle: textTheme.bodyLarge?.copyWith(
                              fontSize: 15.0,
                              color: primaryColor,
                            ),
                            lessStyle: textTheme.bodyLarge?.copyWith(
                              fontSize: 15.0,
                              color: primaryColor,
                            ),
                          )
                        : Text(
                            widget.propertyModel.description,
                            style: textTheme.bodyLarge?.copyWith(
                              fontSize: 14.0,
                              color: grey.withOpacity(0.8),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Overview",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Furnishing : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "${widget.propertyModel.furnishing}",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Available from : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "Available now",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lease type : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "${widget.propertyModel.leaseType}",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Gas Pipeline : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "${widget.propertyModel.gasPipeline ? "Yes" : 'No'}",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Parking : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "${widget.propertyModel.parking}",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Maintance : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "1000 per month",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Price Negotiable : ",
                        style: textTheme?.bodyLarge?.copyWith(fontSize: 14.0),
                      ),
                      Text(
                        "No",
                        style: textTheme?.labelLarge?.copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bottomNavigationItem(
                screenWidth: screenWidth,
                textTheme: textTheme,
                icon: FontAwesomeIcons.message,
                imageIcon: "",
                label: "Message",
                isSelected: false,
                onClick: () {
                  context.read<MessageBloc>().add(GetMessageEvent(
                      map: {"recieverId": widget.propertyModel.title}));
                  context.pushScreen(
                      nextScreen: IndividualPage(
                    recieverId: widget.propertyModel.title,
                  ));
                },
              ),
              const SizedBox(
                height: 30,
                child: VerticalDivider(
                  color: midLightGrey,
                ),
              ),
              bottomNavigationItem(
                screenWidth: screenWidth,
                textTheme: textTheme,
                icon: FontAwesomeIcons.phone,
                imageIcon: "",
                label: "Call",
                isSelected: false,
                onClick: () {},
              ),
            ],
          ),
        ));
  }
}
