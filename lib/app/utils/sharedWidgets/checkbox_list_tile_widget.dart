import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_button_widget.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_widget.dart';
import '../helpers/platform_type.dart';
import '../stylePages/app_colors.dart';

class CheckboxListTileWidget extends StatefulWidget {
  final String radioText;
  final bool checked;
  final bool withExpanded;
  final bool? justRead;
  final double? size;
  final double? spaceBetween;
  final Color? checkedColor;
  final Color? titleColor;
  final Color? activeColor;
  final Color? borderColor;
  final Function()? onChanged;

  const CheckboxListTileWidget({
    Key? key,
    required this.radioText,
    this.withExpanded = true,
    this.justRead,
    this.size,
    this.spaceBetween,
    this.checkedColor,
    this.titleColor,
    this.activeColor,
    this.borderColor,
    required this.checked,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CheckboxListTileWidget> createState() => _CheckboxListTileWidgetState();
}

class _CheckboxListTileWidgetState extends State<CheckboxListTileWidget> {
  Widget buildCheckBox() => Padding(
    padding: EdgeInsets.only(left: widget.spaceBetween ?? 2.w),
    child: TextWidget(
      widget.radioText,
      textColor: widget.titleColor ?? AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: PlatformType.isAndroid() ? 15.sp : 14.sp,
      maxLines: 1,
      textAlign: TextAlign.start,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.justRead ?? false,
      child: TextButtonWidget(
        componentPadding: EdgeInsets.zero,
        onTap: widget.onChanged,
        widgetCustom: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: widget.size ?? 2.h,
              width: widget.size ?? 2.h,
              child: Transform.scale(
                scale: .1.h,
                child: Checkbox(
                  checkColor: widget.checkedColor ?? AppColors.whiteColor,
                  activeColor: widget.activeColor ?? AppColors.blackColor,
                  value: widget.checked,
                  hoverColor: AppColors.blackColor,
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      width: .25.h,
                      color: widget.borderColor ?? AppColors.blackColor,
                    ),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) => widget.onChanged!(),
                ),
              ),
            ),
            if(widget.withExpanded)
              Expanded(
                child: buildCheckBox(),
              )
            else
              buildCheckBox(),
          ],
        ),
      ),
    );
  }
}