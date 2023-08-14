import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class TextFieldResizeWidget extends StatelessWidget {
  final String? hintText;
  final int? maxLength;
  final bool? ableField;
  final bool? justRead;
  final bool? enableSuggestions;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? maskTextInputFormatter;
  final FilteringTextInputFormatter? filteringTextInputFormatter;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final TextCapitalization? textCapitalization;
  final TextEditingController controller;

  const TextFieldResizeWidget({
    Key? key,
    this.hintText,
    this.maxLength,
    this.ableField,
    this.justRead,
    this.enableSuggestions,
    this.height,
    this.width,
    this.fontSize,
    this.textColor,
    this.hintTextColor,
    this.borderColor,
    this.textStyle,
    this.textAlign,
    this.textAlignVertical,
    this.focusNode,
    this.keyboardType,
    this.decoration,
    this.maskTextInputFormatter,
    this.filteringTextInputFormatter,
    this.textInputAction,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
    this.textCapitalization,
    required this.controller,
  }) : super(key: key);

  InputDecoration standardDecoration() {
    double heightInput = height ?? 65;
    return InputDecoration(
      labelText: hintText,
      labelStyle: TextStyle(
        fontSize: 16.sp,
        color: hintTextColor ?? AppColors.defaultColor,
      ),
      counterText: "",
      enabledBorder: _getBorderLayout(),
      border: _getBorderLayout(),
      focusedBorder: _getBorderLayout(),
      contentPadding: EdgeInsets.only(bottom: heightInput / 2, left: 10, right: 10),
    );
  }

  TextStyle standardTextStyle() {
    return TextStyle(
      color: textColor ?? AppColors.blackColor,
      fontSize: fontSize ?? 16.sp,
    );
  }

  OutlineInputBorder _getBorderLayout() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: borderColor ?? AppColors.defaultColor,
        width: .25.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: justRead ?? false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: (height ?? 65) * 3,
          minHeight: height ?? 65,
        ),
        child: TextField(
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
          maxLines: null,
          enableSuggestions: enableSuggestions ?? false,
          style: textStyle ?? standardTextStyle(),
          textAlign: textAlign ?? TextAlign.start,
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
          focusNode: focusNode,
          cursorColor: AppColors.blackColor,
          keyboardType: keyboardType ?? TextInputType.multiline,
          decoration: decoration ?? standardDecoration(),
          inputFormatters: maskTextInputFormatter,
          enabled: ableField ?? true,
          textInputAction: textInputAction,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          controller: controller,
        ),
      ),
    );
  }
}
