import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class PinPutWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final TextEditingController pinController;

  const PinPutWidget(
  { Key? key,
    this.height,
    this.width,
    required this.pinController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      controller: pinController,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      length: 6,
      showCursor: true,
      defaultPinTheme: PinTheme(
        width: width ?? 65,
        height: height ?? 65,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: AppColors.defaultColor,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.defaultColor,
            width: .25.h,
          ),
          borderRadius: BorderRadius.circular(1.h),
        ),
      ),
    );
  }
}