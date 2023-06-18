import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../base/models/gym/gym.dart';
import '../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../utils/sharedWidgets/text_button_widget.dart';
import '../../utils/stylePages/app_colors.dart';

class GymWidget extends StatelessWidget {
  final Gym gym;
  final Function onTap;
  final bool disableStyle;

  const GymWidget({
    Key? key,
    required this.onTap,
    required this.gym,
    this.disableStyle = false,
  }) : super(key: key);

  Widget getCheckboxWidget() => TextButtonWidget(
    widgetCustom: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTileWidget(
              radioText: gym.name,
              size: 2.h,
              checked: gym.selected,
              titleColor: AppColors.whiteColor,
              borderColor: AppColors.whiteColor,
              activeColor: AppColors.transparentColor,
              justRead: true,
              onChanged: (){},
            ),
          ),
        ],
      ),
    ),
    onTap: () async => onTap(),
  );

  @override
  Widget build(BuildContext context) {
    return disableStyle ? getCheckboxWidget() : Container(
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.h),
        border: Border.all(
          color: AppColors.redColor,
          width: .25.h,
        ),
        color: AppColors.defaultColor,
      ),
      child: getCheckboxWidget(),
    );
  }
}
