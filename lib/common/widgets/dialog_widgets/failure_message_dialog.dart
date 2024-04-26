import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/widgets/app_input_field.dart';
import 'package:tiffen_wala_user/common/widgets/common_space.dart';
import 'package:tiffen_wala_user/common/widgets/custom_button.dart';
import 'package:tiffen_wala_user/common/widgets/text_view.dart';

class ErrorDailog extends StatelessWidget {
  final Function() onTap;
  final String title;

  final String message;

  final Function()? dismiss;
  TextTheme? textTheme;

  ErrorDailog(
      {super.key,
      required this.onTap,
      this.dismiss,
      this.textTheme,
      required this.message,
      required this.title});

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [mainView()],
    );
  }

  Widget mainView() {
    return Column(
      children: [
        Lottie.asset(
          "assets/lottie/error_new.json",
          fit: BoxFit.fill,
          height: 150

        ),
        spaceVertical(space: 10),
        Text(
          "$message",
          style: textTheme?.headlineSmall?.copyWith(fontSize: 15, color: black),
        ),
        spaceVertical(space: 30),
        CustomButton(
          text: "OK",
          borderRadius: 10,
          onPressed: onTap,
        )
      ],
    );
  }
}
