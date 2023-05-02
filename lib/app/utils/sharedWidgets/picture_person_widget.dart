import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../stylePages/app_colors.dart';

class PicturePersonWidget extends StatelessWidget {
  final String path;
  final bool fromAsset;
  final Function? onDelete;

  const PicturePersonWidget({
    Key? key,
    required this.path,
    this.fromAsset = false,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 70.w,
      child: Stack(
        children: [
          Container(
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
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => onDelete != null ? onDelete!() : null,
              child: Container(
                padding: EdgeInsets.all(.5.h),
                margin: EdgeInsets.only(top: 1.h, right: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.h),
                  color: AppColors.black40TransparentColor,
                ),
                child: Icon(
                  Icons.close,
                  color: AppColors.whiteColor,
                  size: 3.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
