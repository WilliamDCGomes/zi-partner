import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_widget.dart';
import '../../../base/models/loggedUser/logged_user.dart';
import '../stylePages/app_colors.dart';

class ProfileImagePictureWidget extends StatefulWidget {
  final double? fontSize;
  final RxBool loadingPicture;
  final RxBool hasPicture;
  final RxString profileImagePath;

  const ProfileImagePictureWidget({
    Key? key,
    this.fontSize,
    required this.loadingPicture,
    required this.hasPicture,
    required this.profileImagePath,
  }) : super(key: key);

  @override
  State<ProfileImagePictureWidget> createState() => _ProfileImagePictureWidgetState();
}

class _ProfileImagePictureWidgetState extends State<ProfileImagePictureWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => widget.loadingPicture.value ?
      SizedBox(
        height: 20.h,
        width: 20.h,
        child: const CircularProgressIndicator(),
      ) :
      widget.hasPicture.value ?
      Container(
        height: 20.h,
        width: 20.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MemoryImage(
              base64Decode(widget.profileImagePath.value),
            ),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
          color: AppColors.grayBackgroundPictureColor,
        ),
      ) :
      Container(
        height: 20.h,
        width: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          color: AppColors.defaultColor,
        ),
        child: Center(
          child: TextWidget(
            LoggedUser.nameInitials,
            textColor: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: widget.fontSize ?? 30.sp,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
