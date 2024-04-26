import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';
import 'package:tiffen_wala_user/common/utils/app_extension.dart';
import 'package:tiffen_wala_user/common/widgets/progress_bar_with_text.dart';




void showSnackBar(BuildContext context, String title, String message) {
  message.printLog(msg: "showSnackBar>>>>>>>>>>>>>>>>>>>>>>") ;
  Flushbar(
    title: title,
    flushbarPosition: FlushbarPosition.TOP,
    message: message??"test",
    backgroundGradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
    backgroundColor: Colors.red,
    isDismissible: true,
    duration: Duration(seconds: 2),
    boxShadows: [
      BoxShadow(
        color: Colors.blue,
        offset: Offset(0.0, 2.0),
        blurRadius: 3.0,
      )
    ],
  )..show(context);
}

void showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return ProgressBarWithText(text: "Loading...");
    },
  );
}

String _currencySymbol = "";

String getCurrencySymbol(BuildContext context) {
  if (_currencySymbol.isEmpty) {
    _currencySymbol = NumberFormat.simpleCurrency(
            locale: Localizations.localeOf(context).toString())
        .currencySymbol;
  }
  return _currencySymbol;
}

extension TextStyleX on TextStyle {
  /// A method to underline a text with a customizable [distance] between the text
  /// and underline. The [color], [thickness] and [style] can be set
  /// as the decorations of a [TextStyle].
  TextStyle underlined({
    Color? color,
    double distance = 1,
    double thickness = 1,
    TextDecorationStyle style = TextDecorationStyle.solid,
  }) {
    return copyWith(
      shadows: [
        Shadow(
          color: this.color ?? Colors.black,
          offset: Offset(0, -distance),
        )
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationThickness: thickness,
      decorationColor: color ?? this.color,
      decorationStyle: style,
    );
  }
}

Widget bottomNavigationItem({
  required textTheme,
  required double screenWidth,
  required String imageIcon,
  required IconData icon,
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
                              valueColor: const AlwaysStoppedAnimation(
                                  primaryColorVariant),
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
                  Icon(
                    icon,
                    size: 20,
                    color: isSelected ? primaryColor : grey,
                  ),

                  // Image.asset(
                  //   imageIcon,
                  //   height: 20,
                  //   width: 20,
                  //   color: isSelected ? primaryColor : grey,
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    label,
                    style: textTheme?.titleSmall!.copyWith(
                      color: isSelected ? primaryColor : grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
