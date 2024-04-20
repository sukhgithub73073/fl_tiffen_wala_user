import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tiffen_wala_user/blocs/location_bloc/location_bloc.dart';
import 'package:tiffen_wala_user/blocs/property_bloc/property_bloc.dart';
import 'package:tiffen_wala_user/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:tiffen_wala_user/common/app_data.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/models/category_model.dart';
import 'package:tiffen_wala_user/common/widgets/add_filter_widget.dart';
import 'package:tiffen_wala_user/common/widgets/app_tap_widget.dart';
import 'package:tiffen_wala_user/common/widgets/circular_image.dart';
import 'package:tiffen_wala_user/common/widgets/search_bar_widget.dart';
import 'package:tiffen_wala_user/features/home/delivery_location/screens/choose_delivery_location_screen.dart';
import 'package:tiffen_wala_user/features/home/home/widgets/property_category_widget.dart';
import 'package:tiffen_wala_user/features/home/home/widgets/property_item.dart';
import 'package:tiffen_wala_user/features/home/home/widgets/recipe_item_widget.dart';
import 'package:tiffen_wala_user/common/widgets/restaurant_item_widget.dart';
import 'package:tiffen_wala_user/common/models/pair.dart';
import 'package:tiffen_wala_user/features/home/restaurant_page/screens/restaurant_page_screen.dart';
import 'package:tiffen_wala_user/features/home/restaurants_and_dishes/restaurants_and_dishes_screen.dart';
import 'package:tiffen_wala_user/features/home/search_screen/search_screen.dart';
import 'package:tiffen_wala_user/navigation/navigation.dart';

class HomeScreenProperty extends ConsumerStatefulWidget {
  const HomeScreenProperty({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenPropertyState();
}

class _HomeScreenPropertyState extends ConsumerState<HomeScreenProperty> {
  Map<String, dynamic> map = {};

  final searchController = TextEditingController();
  List<CategoryModel> categoryList = [
    CategoryModel(
        name: "All", icon: FontAwesomeIcons.boxesStacked, isSelected: true),
    CategoryModel(
        name: "Rent",
        icon: FontAwesomeIcons.buildingColumns,
        isSelected: false),
    CategoryModel(name: "Buy", icon: FontAwesomeIcons.shop, isSelected: false),
    CategoryModel(
        name: "Commercial", icon: FontAwesomeIcons.building, isSelected: false),
    CategoryModel(name: "PG", icon: FontAwesomeIcons.house, isSelected: false),
    CategoryModel(
        name: "Plots", icon: FontAwesomeIcons.landmark, isSelected: false),
  ];

  final List<String> imageUrls = [
    "assets/images/zomato_offer_icon.png",
    "assets/images/banner_one.png",
  ];

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<PropertyBloc, PropertyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PreferredSize(
                preferredSize: const Size.fromHeight(55),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: primaryColorVariant,
                        size: 25,
                      ),
                      Expanded(
                        child: BlocConsumer<LocationBloc, LocationState>(
                          listener: (context, state) {
                            if (state is LocationGpsDisable) {
                            } else if (state is LocationGpsEnable) {
                              context
                                  .read<LocationBloc>()
                                  .add(CheckPermissionEvent());
                            } else if (state is LocationPermisionNotGrant) {
                            } else if (state is LocationPermisionGrant) {
                              context
                                  .read<LocationBloc>()
                                  .add(GetCurrentLocationEvent());
                            } else if (state is LocationFetch) {
                              map["latitute"] =
                                  state.currentLocationModel.latitute;
                              map["longitude"] =
                                  state.currentLocationModel.longitude;
                              context
                                  .read<PropertyBloc>()
                                  .add(GetPropertyListEvent(map: map));
                            } else {}
                          },
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            ChooseDeliveryLocationScreen
                                                .routeName);
                                      },
                                      child: Text(
                                        state is LocationFetch
                                            ? state
                                                .currentLocationModel.location
                                            : "Fetching location...",
                                        style: textTheme.labelSmall?.copyWith(
                                          color: black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  // Text(
                                  //   "India",
                                  //   style: textTheme.labelSmall?.copyWith(
                                  //     color: grey,
                                  //     fontSize: 13,
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.watch(homeNavigation.notifier).state = 1;
                        },
                        child: const CircularImage(
                          imageLink:
                              "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492_1280.jpg",
                          radius: 19,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              title: SearchBarWidget(
                iconData: Icons.filter_list,
                leading: Pair(
                  Icons.search_rounded,
                  () {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                ),
                hint: "Search for landmark or builder...",
                onClick: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
              automaticallyImplyLeading: false,
              backgroundColor: white,
              elevation: 0,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 140,
                    // Adjust the height of the container as needed
                    child: CarouselSlider.builder(
                      itemCount: imageUrls.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        // Set to true for autoplay
                        aspectRatio: 16 / 9,
                        // Adjust the aspect ratio as needed
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                      ),
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(imageUrls[index]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: lightGrey,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "WHAT'S ON YOUR MIND?",
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                    color: grey,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: lightGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 130,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(right: 15),
                            itemCount: categoryList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    TapWidget(
                                      onTap: () {
                                        setState(() {
                                          map["type"] = index == 0
                                              ? ""
                                              : categoryList[index].name;
                                          context.read<PropertyBloc>().add(
                                              GetPropertyListEvent(map: map));

                                          categoryList.forEach((element) {
                                            element.isSelected = false;
                                          });
                                          categoryList[index].isSelected = true;
                                        });
                                      },
                                      child: CategoryItemWidget(
                                        categoryModel: categoryList[index],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: lightGrey,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0)
                                      .copyWith(bottom: 10),
                              child: Text(
                                "ALL PROPERTIES",
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: 14,
                                  color: grey,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: lightGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 14),
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(right: 15).copyWith(left: 6),
                  scrollDirection: Axis.horizontal,
                  children: [
                    AddFilterWidget(
                      icon: "assets/images/filter_icon.png",
                      tag: "Sort",
                      hasMultiOption: true,
                      onClick: () {},
                    ),
                    AddFilterWidget(tag: "Nearest", onClick: () {}),
                    AddFilterWidget(tag: "Rating 4.0+", onClick: () {}),
                    AddFilterWidget(tag: "New Arrivals", onClick: () {}),
                  ],
                ),
              ),
              backgroundColor: white,
              elevation: 0,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocConsumer<PropertyBloc, PropertyState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Center(
                        child: Text(
                          state is PropertySuccess
                              ? "${state.propertyList.length} property nearest to you"
                              : "Fetching nearest property",
                          style: textTheme.bodyLarge?.copyWith(
                            color: midLightGrey,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            if (state is PropertySuccess) ...[
              SliverList.builder(
                itemCount: state.propertyList.length,
                itemBuilder: (context, index) {
                  return TapWidget(
                    onTap: () async {
                      // final FirebaseFirestore firestore = FirebaseFirestore.instance;
                      // final DocumentReference propertyRef = await firestore.collection('Properties').add({
                      //   "seller_id" : "SEL345534",
                      //   "title" : "2 BHK Flat for Rent",
                      //   "description" : "This Flat can be a comfortable and affordable home for your family. It is a 2 BHK unit available on rent at Bhago Majra in Mohali. This Flat comes with a plethora of amenities to meet your modern lifestyle needs. It is fully furnished. It is located",
                      //   "area":1200,
                      //   "price":15000,
                      //   "address":"Crest I, Bhago Majra, Mohali",
                      //   "latitute":37.54545,
                      //   "longitude":73.54544,
                      //   "furnishing":"Fully Furnished",
                      //   "bedrooms":2,
                      //   "bathrooms":2,
                      //   "lease_type":"Bachelor",
                      //   "parking":"No Parking" ,
                      //   "type":"Rent" ,
                      //   "gas_pipeline":true,
                      // });
                      //
                      // final CollectionReference imagesRef = propertyRef.collection('Images');
                      //
                      // imagesRef.add({
                      //   "url":"https://housing-images.n7net.in/012c1500/bfb7ff64119352b02d58a8834340443d/v0/fs.jpg"
                      // });
                      // imagesRef.add({
                      //   "url":"https://housing-images.n7net.in/012c1500/3aab62c636ee1dbadf74ededd48455c8/v0/fs-large.jpg"
                      // });



                    },
                    child: PropertyItemWidget(
                      propertyModel: state.propertyList[index],
                    ),
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
