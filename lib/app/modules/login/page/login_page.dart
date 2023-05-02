import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/helpers/paths.dart';
import '../../../utils/helpers/app_close_controller.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../../utils/sharedWidgets/rich_text_two_different_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../registerUser/page/register_user_page.dart';
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
  late LoginController controller;

  @override
  void initState() {
    controller = Get.put(LoginController(widget.cancelFingerPrint));
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
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: [
                  Container(
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.h)),
                      color: AppColors.defaultColor,
                      image: const DecorationImage(
                        image: AssetImage(
                          Paths.academiaImagem,
                        ),
                        fit: BoxFit.fill,
                        opacity: .3,
                      ),
                    ),
                    child: Center(
                      child: TextWidget(
                        "Zi Partner",
                        textColor: AppColors.whiteColorWithOpacity,
                        fontSize: 35.sp,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                        maxLines: 4,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 10.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(15.h)),
                        color: AppColors.defaultColor,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: KeyboardVisibilityBuilder(
                          builder: (context, isKeyboardVisible){
                            if(!isKeyboardVisible){
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Obx(
                                  () => Visibility(
                                    visible: controller.appVersion.value.isNotEmpty,
                                    child: TextWidget(
                                      "Versão: ${controller.appVersion.value}",
                                      textColor: AppColors.whiteColor,
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28.h),
                    child: Scaffold(
                      backgroundColor: AppColors.transparentColor,
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [

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
                                        textColor: AppColors.blackColor,
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
                                              hasError: controller.loginInputHasError.value,
                                              enableSuggestions: true,
                                              textInputAction: TextInputAction.next,
                                              height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                              width: double.infinity,
                                              keyboardType: TextInputType.name,
                                              textCapitalization: TextCapitalization.words,
                                              maskTextInputFormatter: [MasksForTextFields.loginMask],
                                              onEditingComplete: (){
                                                controller.passwordInputFocusNode.requestFocus();
                                              },
                                              validator: (String? value) {
                                                String? validation = TextFieldValidators.loginValidation(value);
                                                if(validation != null && validation != ""){
                                                  controller.loginInputHasError.value = true;
                                                }
                                                else{
                                                  controller.loginInputHasError.value = false;
                                                }
                                                return validation;
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
                                                  color: AppColors.blackColor,
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
                                                  onTap: () {

                                                  }
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
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.5.h),
                                      child: TextButtonWidget(
                                        onTap: () => Get.to(() => const RegisterUserPage()),
                                        richText: const RichTextTwoDifferentWidget(
                                          firstText: "Não tem Cadastro? ",
                                          secondText: "Clique Aqui!",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}