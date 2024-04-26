
import 'package:flutter/material.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';


appDialog({required BuildContext context, required Widget child}) {
  showDialog(
      context: context,
      useSafeArea: true,
      builder: (_) => AnimateDialog(
        childView: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: white,
          insetPadding: EdgeInsets.symmetric(horizontal: 16 , vertical: 40),
          content: Container(
              width: double.maxFinite,
              child: child),
        ),
      )
  );
}
class AnimateDialog extends StatelessWidget {
  final Widget childView;
  const AnimateDialog({super.key,  required this.childView});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        tween: Tween<double>(begin: 0, end: 1),
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.scale(
            scale: value,
            child: childView,
          );
        });
  }
}

