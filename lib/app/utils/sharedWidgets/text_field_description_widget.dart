import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';
import 'text_field_widget.dart';
import 'text_widget.dart';

class TextFieldDescriptionWidget extends StatelessWidget {
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final bool? ableField;
  final bool? justRead;
  final bool? isPassword;
  final bool? enableSuggestions;
  final bool? hasError;
  final double? height;
  final double? width;
  final double? fontSize;
  final Widget? iconTextField;
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
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final TextEditingController controller;
  final AutovalidateMode? autovalidateMode;

  const TextFieldDescriptionWidget({
    Key? key,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.ableField,
    this.justRead,
    this.isPassword,
    this.enableSuggestions,
    this.hasError,
    this.height,
    this.width,
    this.fontSize,
    this.iconTextField,
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
    this.onSaved,
    this.validator,
    this.textCapitalization,
    required this.controller,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: controller,
      height: height ?? 19.h,
      width: width,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textAlignVertical: textAlignVertical,
      maxLength: maxLength,
      maxLines: maxLines ?? 8,
      ableField: ableField,
      justRead: justRead,
      isPassword: isPassword,
      enableSuggestions: enableSuggestions,
      hasError: hasError,
      fontSize: fontSize,
      iconTextField: iconTextField,
      textColor: textColor,
      hintTextColor: hintTextColor,
      borderColor: borderColor,
      textStyle: textStyle,
      textAlign: textAlign,
      focusNode: focusNode,
      maskTextInputFormatter: maskTextInputFormatter,
      filteringTextInputFormatter: filteringTextInputFormatter,
      textInputAction: textInputAction,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: autovalidateMode,
      decoration: decoration ?? InputDecoration(
        label: TextWidget(
          hintText ?? "",
          fontSize: fontSize ?? 16.sp,
          textColor: AppColors.blackColor,
        ),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.blackColor,
            width: .25.h,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.blackColor,
            width: .25.h,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.blackColor,
            width: .25.h,
          ),
        ),
        contentPadding: EdgeInsets.all(1.5.h),
      ),
    );
  }
}
