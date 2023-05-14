import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../helpers/platform_type.dart';
import '../stylePages/app_colors.dart';
import 'text_widget.dart';

class InformationContainerWidget extends StatelessWidget {
  final Widget? customContainer;
  final EdgeInsets? marginContainer;
  final EdgeInsets? marginIcon;
  final EdgeInsets? padding;
  final String iconPath;
  final String informationText;
  final bool disableWhiteIconColor;
  final bool showBorder;
  final Color textColor;
  final Color backgroundColor;

  const InformationContainerWidget(
      { Key? key,
        this.customContainer,
        this.marginContainer,
        this.marginIcon,
        this.padding,
        this.disableWhiteIconColor = false,
        this.showBorder = false,
        required this.iconPath,
        required this.informationText,
        required this.textColor,
        required this.backgroundColor,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: marginContainer ?? EdgeInsets.only(
            left: 2.w,
            top: PlatformType.isTablet(context) ? 7.h : 5.h,
            right: 2.w,
            bottom: 2.h,
          ),
          padding: padding ?? EdgeInsets.fromLTRB(5.w, 4.h, 5.w, 3.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.h),
            color: backgroundColor,
            border: showBorder ? Border.all(
              width: .25.h,
              color: AppColors.redColor,
            ) : null,
          ),
          child: customContainer ?? TextWidget(
            informationText,
            textColor: textColor,
            fontSize: 18.sp,
            textAlign: TextAlign.center,
            maxLines: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: EdgeInsets.all(1.5.h),
            margin: marginIcon,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.5.h),
              color: backgroundColor,
              border: showBorder ? Border.all(
                width: .25.h,
                color: AppColors.redColor,
              ) : null,
            ),
            child: Image.asset(
              iconPath,
              height: 5.h,
              width: 5.h,
              color: disableWhiteIconColor ? null : AppColors.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}