import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiffen_wala_user/common/constants/colors.dart';

typedef StringToVoidFunc = void Function(String);

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final int? lines;
  final bool? obsecureText;
  final Color? borderColor;
  final Widget? preffixicon;
  final Widget? suffixicon;
  final Color? hintTextColor;
  final Color? prefixIconColor;
  final int? numberOfLines;
  final int? maxLength;
  final double paddingHorizontal;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final FontWeight? hintFontWeight;
  final double? hintTextSize;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final StringToVoidFunc? onChanged;
  final StringToVoidFunc? onFieldSubmitted;
  final String? initialValue;
  final Color? textColor;
  final String? fontFamily;
  final double? borderRadius;
  final bool hasViewHight;
  final EdgeInsets? contentPadding;
  final String? error;
  final GestureTapCallback? onTab;

  const CustomTextField({
    super.key,
    this.onChanged,
    this.hintText = "",
    this.labelText = "",
    this.lines,
    this.obsecureText,
    this.borderColor,
    this.preffixicon,
    this.hintTextColor,
    this.prefixIconColor,
    this.numberOfLines,
    this.maxLength,
    this.paddingHorizontal = 0,
    this.suffixicon,
    this.readOnly,
    this.textInputAction,
    this.hintFontWeight,
    this.hintTextSize,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.initialValue,
    this.textColor,
    this.onTab,
    this.fontFamily,
    this.borderRadius,
    this.hasViewHight = true,
    this.contentPadding,
    this.error,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: darkGrey, width: 1.5),
    );
    final normalBorder = enabledBorder.copyWith(
      borderSide: BorderSide(
        color: midLightGrey.withOpacity(0.5),
      ),
    );
    return TextFormField(
      style: textTheme.bodyLarge?.copyWith(fontSize: 15),
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      obscureText: widget.obsecureText ?? false,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.numberOfLines,
      minLines: widget.numberOfLines,
      maxLength: widget.maxLength ?? null,
      onTap: widget.onTab,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        isDense: true,
        isCollapsed: true,
        labelStyle: textTheme.labelSmall?.copyWith(
          fontSize: 14,
          color: focusNode.hasFocus ? grey : midLightGrey,
        ),
        floatingLabelStyle: textTheme.labelSmall?.copyWith(
          fontSize: 16,
          color: focusNode.hasFocus ? grey : midLightGrey,
        ),
        border: normalBorder,
        focusedBorder: enabledBorder,
        disabledBorder: normalBorder,
        enabledBorder: normalBorder,
        errorText: widget.error != null && widget.error!.trim().length > 0
            ? widget.error
            : null,
        prefixIcon: widget.preffixicon,
        suffixIcon: widget.suffixicon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
    );
  }
}

class Family {
  static String light = "Montserrat-Light";
  static String regular = "Montserrat-Regular";
  static String medium = "Montserrat-Medium";
  static String semiBold = "Montserrat-SemiBold";
  static String bold = "Montserrat-SemiBold";
}
