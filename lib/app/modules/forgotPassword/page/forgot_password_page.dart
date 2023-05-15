import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/information_container_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key,}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late ForgotPasswordController controller;

  @override
  void initState() {
    controller = Get.put(ForgotPasswordController());
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
                          title: "Esqueceu a Senha",
                        ),
                        const InformationContainerWidget(
                          iconPath: Paths.iconeExibicaoEsqueciSenha,
                          textColor: AppColors.whiteColor,
                          backgroundColor: AppColors.defaultColor,
                          informationText: "Informe o seu E-mail para recuperar a sua senha",
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Form(
                                  key: controller.formKey,
                                  child: Obx(
                                    () => TextFieldWidget(
                                      controller: controller.emailInputController,
                                      hintText: "Informe o E-mail",
                                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                      width: double.infinity,
                                      keyboardType: TextInputType.emailAddress,
                                      enableSuggestions: true,
                                      hasError: controller.emailInputHasError.value,
                                      validator: (String? value) {
                                        String? validation = TextFieldValidators.emailValidation(value);
                                        if(validation != null && validation != ""){
                                          controller.emailInputHasError.value = true;
                                        }
                                        else{
                                          controller.emailInputHasError.value = false;
                                        }
                                        return validation;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h,),
                                child: ButtonWidget(
                                  hintText: "ENVIAR",
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
