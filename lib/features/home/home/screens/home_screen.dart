import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiffen_wala_user/blocs/app_type_bloc/app_type_bloc.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/enums/app_type_enum.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/common/utils/utils.dart';
import 'package:tiffen_wala_user/features/home/delivery/screens/delivery_screen.dart';
import 'package:tiffen_wala_user/features/home/home/screens/home_screen_property.dart';
import 'package:tiffen_wala_user/features/home/money/screens/money_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home-screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  List<Widget> screens = [];
  var _currentPage = 0;
  var screenWidth = 0.0;
  TextTheme? textTheme;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    screens = [
      const DeliveryScreen(),
      const HomeScreenProperty(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    textTheme = Theme.of(context).textTheme;
    screenWidth = MediaQuery.sizeOf(context).width * 0.35;
    return Scaffold(
      body: SafeArea(
        child: screens[_currentPage],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bottomNavigationItem(
              screenWidth: screenWidth,
              textTheme: textTheme,
              icon: FontAwesomeIcons.pizzaSlice,
              imageIcon:
                  "assets/images/delivery_${_currentPage == 0 ? "selected_" : ""}icon.png",
              label: "Food",
              isSelected: _currentPage == 0,
              onClick: () {
                context.read<AppTypeBloc>().add(ChangeAppTypeEvent(appTypeEnum: AppTypeEnum.foodUser));
                if (_currentPage != 0) {
                  setState(() {
                    _currentPage = 0;
                  });
                }
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

              icon: FontAwesomeIcons.buildingCircleArrowRight,
              imageIcon:
                  "assets/images/wallet_${_currentPage == 1 ? "selected_" : ""}icon.png",
              label: "Property",
              isSelected: _currentPage == 1,
              onClick: () {
                context.read<AppTypeBloc>().add(ChangeAppTypeEvent(appTypeEnum: AppTypeEnum.propertyUser));
                if (_currentPage != 1) {
                  setState(() {
                    _currentPage = 1;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }


}
