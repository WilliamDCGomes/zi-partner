import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_widget.dart';
import 'package:zi_partner/base/models/person/person.dart';
import '../stylePages/app_colors.dart';

class UserPictureWidget extends StatelessWidget {
  final Person person;
  final double? height;
  final double? width;

  const UserPictureWidget({
    Key? key,
    required this.person,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return person.picture != null && person.picture!.isNotEmpty ?
      Container(
        height: height ?? 9.h,
        width: width ?? 9.h,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(4.5.h),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(
              base64Decode(person.picture!.first.base64),
            ),
          ),
        ),
      ) : Container(
        height: height ?? 9.h,
        width: width ?? 9.h,
        padding: EdgeInsets.all(1.h),
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: AppColors.defaultColor,
          borderRadius: BorderRadius.circular(4.5.h),
        ),
        child: Center(
          child: TextWidget(
            person.initialsName,
            fontSize: height != null ? (height! * 20.sp) / 9.h : 18.sp,
            fontWeight: FontWeight.w600,
            textColor: AppColors.whiteColor,
          ),
        ),
    );
  }
}
