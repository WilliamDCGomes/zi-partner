import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../utils/helpers/platform_type.dart';
import '../../utils/sharedWidgets/button_widget.dart';
import '../../utils/sharedWidgets/text_field_widget.dart';
import '../../utils/sharedWidgets/text_widget.dart';
import '../../utils/stylePages/app_colors.dart';
import '../controller/select_gyms_controller.dart';

class GymPopup extends StatelessWidget {
  final TextEditingController gymTextEditingController = TextEditingController();
  final SelectGymsController selectGymsController = Get.find(tag: "gym-controller");

  GymPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: SizedBox(
        height: 50.h,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.h),
          ),
          child: Container(
            width: 75.w,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(1.h),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90.w,
                  padding: EdgeInsets.all(2.h),
                  decoration: BoxDecoration(
                    color: AppColors.defaultColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(1.h),
                      topLeft: Radius.circular(1.h),
                    ),
                  ),
                  child: TextWidget(
                    "Nova Academia",
                    textColor: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: TextFieldWidget(
                          controller: gymTextEditingController,
                          hintText: "Digite o nome da academia",
                          textCapitalization: TextCapitalization.sentences,
                          height: PlatformType.isTablet(context) ? 7.h : 9.h,
                          width: double.infinity,
                          keyboardType: TextInputType.text,
                          enableSuggestions: true,
                        ),
                      ),
                      ButtonWidget(
                        hintText: "SALVAR",
                        fontWeight: FontWeight.bold,
                        widthButton: double.infinity,
                        onPressed: () => selectGymsController.addGymToList(gymTextEditingController.text),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
