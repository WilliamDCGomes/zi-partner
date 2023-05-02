import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_widget.dart';
import '../stylePages/app_colors.dart';

class GymItemList extends StatelessWidget {
  final String gymName;
  final Function? onDelete;

  const GymItemList({
    Key? key,
    required this.gymName,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: AppColors.defaultColor,
        borderRadius: BorderRadius.circular(1.h),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextWidget(
              gymName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
              maxLines: 2,
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          if(onDelete != null)
            InkWell(
              onTap: () => onDelete!(),
              child: Icon(
                Icons.delete,
                size: 2.5.h,
                color: AppColors.whiteColor,
              ),
            ),
        ],
      ),
    );
  }
}
