import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';

class BottomSheetCloseButton extends StatelessWidget {
  const BottomSheetCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      shape: const CircleBorder(),
      color: darkBlack,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.close,
          color: white,
          size: 28,
        ),
      ),
    );
  }
}
