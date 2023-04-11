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
              Align(
                alignment: Alignment.topLeft,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(1.75 / .9),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset(
                      Paths.academiaImagem,
                      height: 25.h,
                      opacity: const AlwaysStoppedAnimation(.4),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(1.75 / .9),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset(
                      Paths.ilustracaoAcademia2,
                      height: 25.h,
                      opacity: const AlwaysStoppedAnimation(.4),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(.15 / 2),
                  child: Transform.scale(
                    scale: 1.2,
                    child: Image.asset(
                      Paths.ilustracaoAcademia1,
                      opacity: const AlwaysStoppedAnimation(.5),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: TextWidget(
                        "Zi Partner",
                        textColor: AppColors.whiteColorWithLessOpacity,
                        fontSize: 35.sp,
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
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColorWithLessOpacity,
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