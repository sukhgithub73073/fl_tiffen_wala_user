import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/enums/order_for.dart';
import 'package:tiffen_wala_user/common/widgets/address_type_widget.dart';
import 'package:tiffen_wala_user/common/widgets/address_widget.dart';
import 'package:tiffen_wala_user/common/widgets/bottom_sheet_close_button.dart';
import 'package:tiffen_wala_user/common/widgets/custom_button.dart';
import 'package:tiffen_wala_user/common/widgets/name_and_phone_number_widget.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({Key? key}) : super(key: key);

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  TextTheme? textTheme;
  var orderFor = OrderFor.myself;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final flatHouseFloorBuildingController = TextEditingController();
  final areaSectorLocalityController = TextEditingController();
  final nearbyLandmarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: Icon(Icons.arrow_back_ios_rounded,),title: Text(
        "Add Menu",
        style: textTheme?.labelLarge?.copyWith(fontSize: 20),
      ),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14)
                  .copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Who are you ordering for?",
                    style: textTheme?.labelSmall?.copyWith(
                      color: grey.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      orderForButtonWidget(
                        label: "Veg",
                        isSelected: orderFor == OrderFor.myself,
                        onClick: () {
                          if (orderFor != OrderFor.myself) {
                            setState(() {
                              orderFor = OrderFor.myself;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      orderForButtonWidget(
                        label: "Non-Veg",
                        isSelected: orderFor == OrderFor.someoneElse,
                        onClick: () {
                          if (orderFor != OrderFor.someoneElse) {
                            setState(() {
                              orderFor = OrderFor.someoneElse;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  if (orderFor == OrderFor.someoneElse)
                    NameAndPhoneNumberWidget(
                      nameController: nameController,
                      phoneController: phoneController,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      "Save address as *",
                      style: textTheme?.labelSmall?.copyWith(
                        color: grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const AddressTypeWidget(),
                  AddressWidget(
                    flatHouseFloorBuildingController:
                    flatHouseFloorBuildingController,
                    areaSectorLocalityController:
                    areaSectorLocalityController,
                    nearbyLandmarkController: nearbyLandmarkController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                    child: CustomButton(
                      text: "Save Address",
                      borderRadius: 10,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderForButtonWidget({
    required String label,
    required bool isSelected,
    required VoidCallback onClick,
  }) =>
      GestureDetector(
        onTap: onClick,
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: primaryColorVariant,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                label,
                style: textTheme?.labelMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
}
