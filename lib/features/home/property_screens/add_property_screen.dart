import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiffen_wala_user/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:tiffen_wala_user/blocs/property_bloc/property_bloc.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/enums/order_for.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/common/utils/utils.dart';
import 'package:tiffen_wala_user/common/widgets/address_form_field_widget.dart';
import 'package:tiffen_wala_user/common/widgets/address_type_widget.dart';
import 'package:tiffen_wala_user/common/widgets/address_widget.dart';
import 'package:tiffen_wala_user/common/widgets/app_dialog.dart';
import 'package:tiffen_wala_user/common/widgets/app_input_field.dart';
import 'package:tiffen_wala_user/common/widgets/app_tap_widget.dart';
import 'package:tiffen_wala_user/common/widgets/bottom_sheet_close_button.dart';
import 'package:tiffen_wala_user/common/widgets/custom_button.dart';
import 'package:tiffen_wala_user/common/widgets/dialog_widgets/failure_message_dialog.dart';
import 'package:tiffen_wala_user/common/widgets/dialog_widgets/success_message_dialog.dart';
import 'package:tiffen_wala_user/common/widgets/multi_select_chips_widget.dart';
import 'package:tiffen_wala_user/common/widgets/name_and_phone_number_widget.dart';
import 'package:tiffen_wala_user/common/widgets/app_chips_widget.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  TextTheme? textTheme;
  List<XFile> files = [];

  var orderFor = OrderFor.myself;
  final titleController = TextEditingController(text: "3 BHK Flat for Rent");
  final descriptionController = TextEditingController(
      text:
          "Check out this Flat available for rent in Thakkarwal in Ludhiana. It is a 3 BHK unit that comes at an affordable rent, with modern features and premium amenities to suit your lifestyle needs.");
  final addressController =
      TextEditingController(text: "Verma property , Thakkarwal, Ludhiana");
  final priceController = TextEditingController(text: "40000");

  final bedroomsController = TextEditingController(text: "3");
  final bathroomsController = TextEditingController(text: "3");
  final areaController = TextEditingController(text: "2000");
  final parkingController = TextEditingController(text: "open parking");

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_rounded,
        ),
        title: Text(
          "Add Property",
          style: textTheme?.labelLarge?.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocConsumer<ImagePickBloc, ImagePickState>(
              listener: (context, state) {
                if (state is ImagePickSuccess) {
                  setState(() {
                    files.add(state.file);
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    files.isNotEmpty
                        ? Image.file(
                            File(files[0].path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          )
                        : Image.asset(
                            "assets/images/add_dummy.png",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 60,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (c, i) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TapWidget(
                                  onTap: () {
                                    context
                                        .read<ImagePickBloc>()
                                        .add(ChangeImagePickEvent(index: i));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: midGrey, width: 2)),
                                    child: files.length > i
                                        ? Image.file(
                                            File(files[i].path),
                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 60,
                                          )
                                        : Image.asset(
                                            "assets/images/add_dummy.png",
                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 60,
                                          ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14).copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: titleController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        hasViewHight: false,
                        labelText: "Title",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: descriptionController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        hasViewHight: false,
                        labelText: "Description",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: addressController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        hasViewHight: false,
                        labelText: "Address",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: priceController,
                        preffixicon: Icon(Icons.currency_rupee),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        hasViewHight: false,
                        labelText: "Price",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Choose property type",
                      style: textTheme?.labelSmall?.copyWith(
                        color: grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                  AppChipsWidget(
                      onChange: (index) {},
                      list: ["Rent", "Buy", "Commercial", "PG", "Plot"]),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Choose furnishing",
                      style: textTheme?.labelSmall?.copyWith(
                        color: grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                  AppChipsWidget(onChange: (index) {}, list: [
                    "Fully Furnished",
                    "Semi Furnished",
                    "Without Furnished"
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Choose lease type",
                      style: textTheme?.labelSmall?.copyWith(
                        color: grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                  MultiSelectChipsWidget(
                      onChange: (list) {},
                      list: ["Family", "Bachelor", "Company"]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Other information",
                    style: textTheme?.labelSmall?.copyWith(
                      color: grey.withOpacity(0.7),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: areaController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        hasViewHight: false,
                        labelText: "Area (Sq ft)",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: bedroomsController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        hasViewHight: false,
                        labelText: "No of bedrooms",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: bathroomsController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        hasViewHight: false,
                        labelText: "No of bathrooms",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                        controller: parkingController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        hasViewHight: false,
                        labelText: "Parking tips",
                        hintText: "",
                        numberOfLines: 1,
                        hintFontWeight: FontWeight.w400,
                        hintTextColor: grey.withOpacity(0.6)),
                  ),
                  BlocConsumer<PropertyBloc, PropertyState>(
                    listener: (context, state) {
                      if (state is PropertyLoading) {
                        showLoaderDialog(context);
                      } else if (state is PropertySuccess) {
                        context.back();
                        appDialog(
                            context: context,
                            child: SuccessDailog(
                              title: "Successfully",
                              onTap: () {
                                context.back();
                                context.back();
                              },
                              message: "Your property added sucessfully",
                            ));
                      } else if (state is PropertyError) {
                        context.back();
                        appDialog(
                            context: context,
                            child: ErrorDailog(
                              title: "Failed",
                              onTap: () {
                                context.back();
                              },
                              message: "${state.error}",
                            ));
                      } else {
                        context.back();
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                        child: CustomButton(
                          text: "Submit",
                          borderRadius: 10,
                          onPressed: () {
                            if (files.isEmpty) {
                              showSnackBar(context, "Invalid Images",
                                  "Please select atleast one image");
                            } else if (titleController.text.isEmpty) {
                              showSnackBar(context, "Invalid Title",
                                  "Please enter valid title");
                            } else if (descriptionController.text.isEmpty) {
                              showSnackBar(context, "Invalid Description",
                                  "Please enter valid description");
                            } else if (addressController.text.isEmpty) {
                              showSnackBar(context, "Invalid Address",
                                  "Please enter valid address");
                            } else if (priceController.text.isEmpty) {
                              showSnackBar(context, "Invalid Price",
                                  "Please enter valid price");
                            } else if (areaController.text.isEmpty) {
                              showSnackBar(context, "Invalid Area",
                                  "Please enter valid area");
                            } else if (bedroomsController.text.isEmpty) {
                              showSnackBar(context, "Invalid Bedrooms",
                                  "Please enter valid no of bedrooms");
                            } else if (bathroomsController.text.isEmpty) {
                              showSnackBar(context, "Invalid Bathrooms",
                                  "Please enter valid no of bathrooms");
                            } else {
                              context
                                  .read<PropertyBloc>()
                                  .add(AddPropertyEvent(map: {
                                    "files": files,
                                    "title": titleController.text,
                                    "description": descriptionController.text,
                                    "area": areaController.text,
                                    "price": priceController.text,
                                    "address": addressController.text,
                                    "bedrooms": bedroomsController.text,
                                    "bathrooms": bathroomsController.text,
                                    "parking": parkingController.text,
                                    "furnishing": "Fully Furnished",
                                    "type": "Rent",
                                    "lease_type": "Family",
                                  }));
                            }
                          },
                        ),
                      );
                    },
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
