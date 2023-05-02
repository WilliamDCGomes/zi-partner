import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/register_user_controller.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  late RegisterUserController controller;

  @override
  void initState() {
    controller = Get.put(RegisterUserController());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        controller.activeStep.value = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return await controller.backButtonPressed();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Material(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppColors.backgroundFirstScreenColor,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h,),
                    child: Scaffold(
                      backgroundColor: AppColors.transparentColor,
                      body: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.h,),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 30.w,
                                child: TitleWithBackButtonWidget(
                                  title: "Cadastro",
                                  backButtonPressedFuctionOverride: () async => await controller.backButtonOverridePressed(),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Obx(
                                    () => controller.headerRegisterStepperList[controller.activeStep.value],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(2.h, 2.h, 2.h, 3.h),
                                    child: Obx(
                                      () => Center(
                                        child: DotStepper(
                                          dotCount: 6,
                                          dotRadius: 1.h,
                                          activeStep: controller.activeStep.value,
                                          shape: Shape.circle,
                                          spacing: 3.w,
                                          indicator: Indicator.magnify,
                                          fixedDotDecoration: const FixedDotDecoration(
                                            color: AppColors.grayStepColor,
                                          ),
                                          indicatorDecoration: const IndicatorDecoration(
                                            color: AppColors.redColor,
                                          ),
                                          tappingEnabled: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.h,),
                                    child: Obx(
                                      () => controller.bodyRegisterStepperList[controller.activeStep.value],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.h,),
                              child: Obx(
                                () => ButtonWidget(
                                  hintText: controller.activeStep.value < 5 ? "AVANÇAR" : "FINALIZAR",
                                  fontWeight: FontWeight.bold,
                                  widthButton: double.infinity,
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    controller.nextButtonPressed();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Obx(() => controller.activeStep.value == 0 ?
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 2.h,),
                                child: TextWidget(
                                  controller.lgpdPhrase,
                                  textColor: AppColors.blackColor,
                                  fontSize: 15.sp,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ) : SizedBox(height: 2.h),
                          ),
                        ],
                      ),
                    ),
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
