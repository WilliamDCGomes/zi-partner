import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/app_close_controller.dart';
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
      child: SafeArea(
        child: Material(
          child: Container(
            color: AppColors.defaultColor,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 7.h),
                        child: TextWidget(
                          "LOGO",
                          textColor: AppColors.defaultColor,
                          fontSize: 26.sp,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          maxLines: 4,
                        ),/*Image.asset(
                          Paths.Logo_Branca,
                          height: PlatformType.isPhone(context) ? 18.h : 12.h,
                        ),*/
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
      ),
    );
  }
}