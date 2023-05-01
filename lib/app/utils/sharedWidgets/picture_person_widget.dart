import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class PicturePersonWidget extends StatelessWidget {
  final String path;
  final bool fromAsset;

  const PicturePersonWidget({
    Key? key,
    required this.path,
    this.fromAsset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 70.w,
      margin: EdgeInsets.only(right: 2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.h),
        border: Border.all(
          color: AppColors.blackColor,
          width: .25.h,
        ),
        image: fromAsset ? DecorationImage(
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
            image: AssetImage(
              path,
            ),
          )
        : DecorationImage(
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fitWidth,
            image: MemoryImage(
              base64Decode(path),
            ),
          ),
      ),
    );
  }
}
