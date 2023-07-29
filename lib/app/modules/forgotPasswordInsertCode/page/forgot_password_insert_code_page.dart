import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/pin_put_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/forgot_password_insert_code_controller.dart';

class ForgotPasswordInsertCodePage extends StatefulWidget {
  final String userEmail;

  const ForgotPasswordInsertCodePage({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<ForgotPasswordInsertCodePage> createState() => _ForgotPasswordInsertCodePageState();
}

class _ForgotPasswordInsertCodePageState extends State<ForgotPasswordInsertCodePage> {
  late ForgotPasswordInsertCodeController controller;

  @override
  void initState() {
    controller = Get.put(ForgotPasswordInsertCodeController(widget.userEmail));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.backgroundFirstScreenColor,
              ),
            ),
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: AppColors.transparentColor,
                  body: Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWithBackButtonWidget(
                          title: "Validação do Código",
                        ),
                        InformationContainerWidget(
                          iconPath: Paths.iconeExibicaoEsqueciSenha,
                          textColor: AppColors.whiteColor,
                          backgroundColor: AppColors.defaultColor,
                          informationText: "Informe o código enviado \npara o E-mail.",
                          marginContainer: EdgeInsets.only(
                            top: PlatformType.isTablet(context) ? 7.h : 5.h,
                            bottom: 2.h,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 2.w, top: 2.h, right: 2.w,),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PinPutWidget(
                                      pinController: controller.pinPutEmailController,
                                      height: 7.h,
                                      width: 6.h,
                                    ),
                                    Obx(
                                      () => Visibility(
                                        visible: controller.showReSendCode.value,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 1.5.h),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () => controller.reSendButtonPressed(),
                                              child: TextWidget(
                                                "Gerar novo código?",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                textColor: AppColors.defaultColor,
                                                textDecoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 2.h,),
                                child: ButtonWidget(
                                  hintText: "VALIDAR",
                                  fontWeight: FontWeight.bold,
                                  widthButton: 90.w,
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    controller.sendButtonPressed();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
