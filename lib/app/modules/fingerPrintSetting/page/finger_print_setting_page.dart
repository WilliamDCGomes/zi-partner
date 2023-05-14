import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/switch_widget.dart';
import '../../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controller/finger_print_setting_controller.dart';

class FingerPrintSettingPage extends StatefulWidget {
  const FingerPrintSettingPage({Key? key}) : super(key: key);

  @override
  State<FingerPrintSettingPage> createState() => _FingerPrintSettingPageState();
}

class _FingerPrintSettingPageState extends State<FingerPrintSettingPage> {
  late FingerPrintSettingController controller;

  @override
  void initState() {
    controller = Get.put(FingerPrintSettingController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.backgroundFirstScreenColor,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TitleWithBackButtonWidget(
                      title: "Configuração da Digital",
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const InformationContainerWidget(
                            iconPath: Paths.iconeConfiguracaoBiometria,
                            textColor: AppColors.whiteColor,
                            backgroundColor: AppColors.defaultColor,
                            informationText: "Configure o acesso do aplicativo pela sua digital!",
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    child: Obx(
                                      () => SwitchWidget(
                                        text: "Habilitar o login por digital?",
                                        checked: controller.fingerPrintLoginChecked.value,
                                        onClicked: () => controller.fingerPrintLoginPressed(),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    child: Obx(
                                      () => SwitchWidget(
                                        text: "Sempre solicitar a digital quando entrar no aplicativo?",
                                        checked: controller.alwaysRequestFingerPrintChecked.value,
                                        justRead: controller.enableAlwaysRequestFingerPrint.value,
                                        onClicked: () => controller.alwaysRequestFingerPrintPressed(),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 1.h),
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    child: Obx(
                                      () => SwitchWidget(
                                        text: "Habilitar a digital para redefinir a senha?",
                                        checked: controller.fingerPrintChangePasswordChecked.value,
                                        onClicked: () => controller.fingerPrintChangePasswordPressed(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.h),
                            child: ButtonWidget(
                              hintText: "SALVAR",
                              focusNode: controller.saveButtonFocusNode,
                              fontWeight: FontWeight.bold,
                              widthButton: double.infinity,
                              onPressed: () => controller.saveButtonPressed(),
                            ),
                          ),
                        ],
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
