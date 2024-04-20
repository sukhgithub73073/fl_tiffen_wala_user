import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/firebaseprovider/firestore_table.dart';
import 'package:tiffen_wala_user/features/home/delivery/screens/delivery_screen.dart';
import 'package:tiffen_wala_user/features/home/home/screens/home_screen_property.dart';
import 'package:tiffen_wala_user/features/home/money/screens/money_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{

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
              imageIcon:
                  "assets/images/delivery_${_currentPage == 0 ? "selected_" : ""}icon.png",
              label: "Food",
              isSelected: _currentPage == 0,
              onClick: () async {

                // final FirebaseFirestore firestore = FirebaseFirestore.instance;
                // final DocumentReference propertyRef = await firestore.collection('Properties').add({                  "seller_id" : "SEL345534",
                //   "title" : "2 BHK Independent Builder Floor for Rent",
                //   "description" : "Check out this Independent Floor available for rent in Kharar in Mohali. It is a 2 BHK unit that comes at an affordable rent, with modern features and premium amenities to suit your lifestyle needs. The unit is Fully Furnished. With numerous new-age",
                //   "area":1800,
                //   "price":23000,
                //   "address":"Sector 125, Kharar, Mohali",
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
                //   "url":"https://housing-images.n7net.in/01c16c28/045cf6537464d1820dfd867538b1ef21/v0/fs-large/2_bhk_apartment-for-rent-aujala-Mohali-hall.jpg"
                // });
                // imagesRef.add({
                //   "url":"https://housing-images.n7net.in/01c16c28/88c55822bf06691c0e9171d55a98161e/v0/fs-large/2_bhk_apartment-for-rent-aujala-Mohali-hall.jpg"
                // });
                // imagesRef.add({
                //   "url":"https://housing-images.n7net.in/01c16c28/bb69a728369ba79b4cbeda26be3ad51b/v0/fs-large/2_bhk_apartment-for-rent-aujala-Mohali-kitchen.jpg"
                // });


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
              imageIcon:
                  "assets/images/wallet_${_currentPage == 1 ? "selected_" : ""}icon.png",
              label: "Propery",
              isSelected: _currentPage == 1,
              onClick: () {
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

  Widget bottomNavigationItem({
    required String imageIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onClick,
  }) =>
      Expanded(
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            color: white,
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.only(bottom: 2),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                isSelected
                    ? SizedBox(
                        width: screenWidth,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 300),
                          builder: (context, value, _) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 3.5,
                                valueColor:
                                    const AlwaysStoppedAnimation(primaryColorVariant),
                                backgroundColor: white,
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 4,
                        width: screenWidth,
                      ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      imageIcon,
                      height: 20,
                      width: 20,
                      color: isSelected ? primaryColor : grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      label,
                      style: textTheme?.titleSmall,
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
}
