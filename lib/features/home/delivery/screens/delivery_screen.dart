import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tiffen_wala_user/blocs/auth_bloc/auth_bloc.dart';
import 'package:tiffen_wala_user/blocs/location_bloc/location_bloc.dart';
import 'package:tiffen_wala_user/blocs/property_bloc/property_bloc.dart';
import 'package:tiffen_wala_user/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:tiffen_wala_user/common/app_data.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/widgets/add_filter_widget.dart';
import 'package:tiffen_wala_user/common/widgets/circular_image.dart';
import 'package:tiffen_wala_user/common/widgets/search_bar_widget.dart';
import 'package:tiffen_wala_user/features/home/delivery_location/screens/choose_delivery_location_screen.dart';
import 'package:tiffen_wala_user/features/home/home/widgets/recipe_item_widget.dart';
import 'package:tiffen_wala_user/common/widgets/restaurant_item_widget.dart';
import 'package:tiffen_wala_user/common/models/pair.dart';
import 'package:tiffen_wala_user/features/home/restaurant_page/screens/restaurant_page_screen.dart';
import 'package:tiffen_wala_user/features/home/restaurants_and_dishes/restaurants_and_dishes_screen.dart';
import 'package:tiffen_wala_user/features/home/search_screen/search_screen.dart';
import 'package:tiffen_wala_user/navigation/navigation.dart';

class DeliveryScreen extends ConsumerStatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends ConsumerState<DeliveryScreen> {
  final searchController = TextEditingController();
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
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // context.read<LocationBloc>().add(CheckGpsEvent());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<RestaurantBloc, RestaurantState>(
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
                              context
                                  .read<RestaurantBloc>()
                                  .add(GetRestaurantListEvent(map: {
                                    "latitute":
                                        state.currentLocationModel.latitute,
                                    "longitude":
                                        state.currentLocationModel.longitude,
                                  }));
                              context
                                  .read<PropertyBloc>()
                                  .add(GetPropertyListEvent(map: {
                                    "latitute":
                                        state.currentLocationModel.latitute,
                                    "longitude":
                                        state.currentLocationModel.longitude,
                                  }));
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
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        splashColor: lightGrey,
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          padding: const EdgeInsets.symmetric(vertical: 5)
                              .copyWith(right: 2, left: 1),
                          decoration: const BoxDecoration(
                              color: transparent,
                              border: Border.fromBorderSide(
                                BorderSide(
                                  color: midGrey,
                                  width: 1,
                                ),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Image.asset(
                            "assets/images/change_language_icon.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.watch(homeNavigation.notifier).state = 1;
                        },
                        child: BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                          },
                          builder: (context, state) {
                            return CircularImage(
                              imageLink:
                                  state is AuthSuccess ? state.userModel.profileImage :  "https://cdn.pixabay.com/photo/2018/02/08/22/27/flower-3140492_1280.jpg",
                              radius: 19,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              title: SearchBarWidget(
                leading: Pair(
                  Icons.search_rounded,
                  () {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                ),
                hint: "Restaurant name or a dish...",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 110,
                          padding: const EdgeInsets.all(15).copyWith(right: 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.fromBorderSide(
                              BorderSide(
                                  color: lightGrey.withOpacity(0.8), width: 1),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Offers",
                                    style: textTheme.displaySmall,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Up to 60% OFF, Flat Discounts, and other great offers",
                                      style: textTheme.labelMedium?.copyWith(
                                        color: midLightGrey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Lottie.asset(
                                "assets/lottie/offers_animation.json",
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          height: 225,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(right: 15),
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    RecipeItemWidget(
                                      recipeName: "Biryani",
                                      recipeImage:
                                          "assets/images/biryani_icon.png",
                                      onClick: () {
                                        Navigator.pushNamed(
                                            context,
                                            RestaurantsAndDishesScreen
                                                .routeName);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RecipeItemWidget(
                                      recipeName: "Fired Rice",
                                      recipeImage:
                                          "assets/images/fried_rice.png",
                                      onClick: () {
                                        Navigator.pushNamed(
                                            context,
                                            RestaurantsAndDishesScreen
                                                .routeName);
                                      },
                                    )
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
                                "ALL RESTAURANTS",
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
                    AddFilterWidget(tag: "Pure Veg", onClick: () {}),
                    AddFilterWidget(tag: "New Arrivals", onClick: () {}),
                    AddFilterWidget(
                        tag: "Cuisines", hasMultiOption: true, onClick: () {})
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
                  BlocConsumer<RestaurantBloc, RestaurantState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Center(
                        child: Text(
                          state is RestaurantSuccess
                              ? "${state.restaurantList.length} restaurants delivering to you"
                              : "Fetching nearest restaurants",
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
            if (state is RestaurantSuccess) ...[
              SliverList.builder(
                itemCount: state.restaurantList.length,
                itemBuilder: (context, index) {
                  return RestaurantItemWidget(
                    imageUrl: state.restaurantList[index].poster,
                    restaurantName: state.restaurantList[index].name,
                    isFavorite: false,
                    rating: 5,
                    speciality: "Indian",
                    foodType: "South Indian",
                    lowestPriceOfItem: 100,
                    deliveryTime: Pair(12, 32),
                    distance: 20,
                    discount: "5% OFF up to 100",
                    onClick: (restaurant) {
                      AppData.restaurantModel = state.restaurantList[index];
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(RestaurantPageScreen.routeName);
                    },
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
