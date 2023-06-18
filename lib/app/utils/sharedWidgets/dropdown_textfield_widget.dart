import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class DropDownTextFieldWidget extends StatelessWidget {
  final bool? clearOption;
  final bool? enableSearch;
  final bool? justRead;
  final bool? hasError;
  final String? hintText;
  final String? idDropDownRefresh;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? backgroundSuggestionsColor;
  final Color? borderColor;
  final GetxController? refreshDropDownController;
  final InputDecoration? decoration;
  final Function()? onChanged;
  final List<DropDownValueModel> dropDownList;
  final SingleValueDropDownController controller;

  const DropDownTextFieldWidget({
    Key? key,
    this.clearOption,
    this.enableSearch,
    this.justRead,
    this.hasError,
    this.hintText,
    this.idDropDownRefresh,
    this.height,
    this.width,
    this.fontSize,
    this.textColor,
    this.hintTextColor,
    this.backgroundSuggestionsColor,
    this.borderColor,
    this.decoration,
    this.onChanged,
    this.refreshDropDownController,
    required this.dropDownList,
    required this.controller,
  }) : super(key: key);

  InputDecoration standardDecoration() {
    double heightInput = height ?? 65;
    if (height != null) {
      heightInput = height!;
    }
    return InputDecoration(
      helperText: "",
      labelText: hintText,
      labelStyle: TextStyle(
        fontSize: 16.sp,
        color: hasError != null && hasError! ? AppColors.redColor : hintTextColor ?? AppColors.blackColor,
      ),
      errorMaxLines: 3,
      enabledBorder: _getBorderLayout(),
      border: _getBorderLayout(),
      focusedBorder: _getBorderLayout(),
      errorBorder: _getErrorBorderLayout(),
      focusedErrorBorder: _getErrorBorderLayout(),
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
        color: hasError != null && hasError! ? AppColors.redColor : borderColor ?? AppColors.blackColor,
        width: .25.h,
      ),
    );
  }

  OutlineInputBorder _getErrorBorderLayout() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: AppColors.redColor,
        width: .25.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: justRead ?? false,
      child: SizedBox(
        height: height ?? 65,
        width: width ?? 200,
        child: GetBuilder(
          init: refreshDropDownController,
          id: idDropDownRefresh,
          builder: (_) => DropDownTextField(
            controller: controller,
            clearOption: true,
            enableSearch: true,
            dropdownColor: backgroundSuggestionsColor ?? AppColors.whiteColor,
            textFieldDecoration: standardDecoration(),
            textStyle: standardTextStyle(),
            searchDecoration: InputDecoration(
              hintText: hintText ?? "",
            ),
            dropDownItemCount: 10,
            dropDownList: dropDownList,
          ),
        ),
      ),
    );
  }
}
