import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/app_close_controller.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/initial_page_controller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late InitialPageController controller;

  @override
  void initState() {
    controller = Get.put(InitialPageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return AppCloseController.verifyCloseScreen();
      },
      child: Material(
        child: Container(
          color: AppColors.defaultColor,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Paths.logoZipartner,
                      height: 12.h,
                      color: AppColors.whiteColor,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: TextWidget(
                        "Zi Partner",
                        textColor: AppColors.whiteColor,
                        fontSize: 35.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                      width: 6.h,
                      child: const CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              controller.loadingWithSuccessOrErrorWidget,
            ],
          ),
        ),
      ),
    );
  }
}