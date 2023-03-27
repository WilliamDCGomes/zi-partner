import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/app_close_controller.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/snackbar_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/login_page_controller.dart';

class LoginPage extends StatefulWidget {
  final bool cancelFingerPrint;

  const LoginPage({
    Key? key,
    this.cancelFingerPrint = false,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginPageController controller;

  @override
  void initState() {
    controller = Get.put(LoginPageController(widget.cancelFingerPrint));
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.backgroundFirstScreenColor,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.h)),
                    color: AppColors.defaultColor,
                  ),
                ),
                Scaffold(
                  backgroundColor: AppColors.transparentColor,
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
                            child: TextWidget(
                              "LOGO",
                              textColor: AppColors.defaultColor,
                              fontSize: 26.sp,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold,
                              maxLines: 4,
                            ),
                            /*Image.asset(
                              Paths.Logo_Branca,
                              width: 40.h,
                            ),*/
                          ),
                          Expanded(
                            child: Form(
                              key: controller.formKey,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w, top: 5.h, right: 5.w),
                                    child: TextWidget(
                                      "FAÇA LOGIN",
                                      textColor: AppColors.defaultColor,
                                      fontSize: 26.sp,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                      maxLines: 4,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.h),
                                    child: Stack(
                                      children: [
                                        Obx(
                                          () => TextFieldWidget(
                                            controller: controller.userInputController,
                                            hintText: "Usuário",
                                            height: 9.h,
                                            width: double.infinity,
                                            hasError: controller.cpfInputHasError.value,
                                            enableSuggestions: true,
                                            keyboardType: TextInputType.number,
                                            maskTextInputFormatter: [MasksForTextFields.cpfMask],
                                            textInputAction: TextInputAction.next,
                                            validator: (String? value) {
                                              String? validation = TextFieldValidators.cpfValidation(value);
                                              if(validation != null && validation != ""){
                                                controller.cpfInputHasError.value = true;
                                              }
                                              else{
                                                controller.cpfInputHasError.value = false;
                                              }
                                              return validation;
                                            },
                                            onEditingComplete: (){
                                              controller.passwordInputFocusNode.requestFocus();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 1.5.h),
                                    child: Stack(
                                      children: [
                                        Obx(
                                          () => TextFieldWidget(
                                            controller: controller.passwordInputController,
                                            focusNode: controller.passwordInputFocusNode,
                                            hintText: "Senha",
                                            height: 9.h,
                                            width: double.infinity,
                                            isPassword: controller.passwordFieldEnabled.value,
                                            hasError: controller.passwordInputHasError.value,
                                            validator: (String? value) {
                                              String? validation = TextFieldValidators.passwordValidation(value);
                                              if(validation != null && validation != ""){
                                                controller.passwordInputHasError.value = true;
                                              }
                                              else{
                                                controller.passwordInputHasError.value = false;
                                              }
                                              return validation;
                                            },
                                            iconTextField: GestureDetector(
                                              onTap: () {
                                                controller.passwordFieldEnabled.value =
                                                !controller.passwordFieldEnabled.value;
                                              },
                                              child: Icon(
                                                controller.passwordFieldEnabled.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: AppColors.defaultColor,
                                                size: 2.5.h,
                                              ),
                                            ),
                                            keyboardType: TextInputType.visiblePassword,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => CheckboxListTileWidget(
                                                  radioText: "Manter-se Conectado?",
                                                  checked: controller.keepConected.value,
                                                  onChanged: (){
                                                    controller.keepConected.value = !controller.keepConected.value;
                                                  },
                                                ),
                                              ),
                                              TextButtonWidget(
                                                hintText: "Esqueceu a Senha?",
                                                fontSize: 15.sp,
                                                height: 3.5.h,
                                                componentPadding: EdgeInsets.zero,
                                                onTap: () => SnackbarWidget(
                                                  warningText: "Aviso",
                                                  informationText: "Teste",
                                                  backgrondColor: AppColors.defaultColor,
                                                  maxLine: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.h),
                                    child: ButtonWidget(
                                      hintText: "LOGAR",
                                      fontWeight: FontWeight.bold,
                                      focusNode: controller.loginButtonFocusNode,
                                      widthButton: 75.w,
                                      onPressed: () => controller.loginPressed(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          KeyboardVisibilityBuilder(
                            builder: (context, isKeyboardVisible){
                              if(!isKeyboardVisible){
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  child: Obx(
                                    () => Visibility(
                                      visible: controller.appVersion.value.isNotEmpty,
                                      child: TextWidget(
                                        "Versão: ${controller.appVersion.value}",
                                        textColor: AppColors.defaultColor,
                                        fontSize: 16.sp,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return SizedBox(height: 3.h,);
                            }
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