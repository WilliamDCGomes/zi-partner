import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/services/user_service.dart';
import '../../../../base/viewControllers/forgetPasswordResponse/forget_password_response.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/save_user_informations.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../login/page/login_page.dart';

class ResetPasswordController extends GetxController {
  final bool resetFromForgetPassword;
  late TextEditingController oldPasswordInput;
  late TextEditingController newPasswordInput;
  late TextEditingController confirmNewPasswordInput;
  late RxBool oldPasswordVisible;
  late RxBool newPasswordVisible;
  late RxBool confirmNewPasswordVisible;
  late RxBool oldPasswordInputHasError;
  late RxBool newPasswordInputHasError;
  late RxBool confirmNewPasswordInputHasError;
  late FocusNode newPasswordFocusNode;
  late FocusNode confirmNewPasswordFocusNode;
  late FocusNode resetPasswordButtonFocusNode;
  late final GlobalKey<FormState> formKey;
  late final LocalAuthentication fingerPrintAuth;
  late SharedPreferences sharedPreferences;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  final ForgetPasswordResponse? forgetPasswordResponse;
  late IUserService _userService;

  ResetPasswordController(this.resetFromForgetPassword, this.forgetPasswordResponse){
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    super.onInit();
  }

  _initializeVariables(){
    oldPasswordInput = TextEditingController();
    newPasswordInput = TextEditingController();
    confirmNewPasswordInput = TextEditingController();
    oldPasswordVisible = true.obs;
    newPasswordVisible = true.obs;
    confirmNewPasswordVisible = true.obs;
    oldPasswordInputHasError = false.obs;
    newPasswordInputHasError = false.obs;
    confirmNewPasswordInputHasError = false.obs;
    newPasswordFocusNode = FocusNode();
    confirmNewPasswordFocusNode = FocusNode();
    resetPasswordButtonFocusNode = FocusNode();
    formKey = GlobalKey<FormState>();
    fingerPrintAuth = LocalAuthentication();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _userService = UserService();
  }

  Future<bool?> _validPasswordReset() async {
    try{
      var valid =  await _userService.authenticate(
        username: LoggedUser.userName,
        password: oldPasswordInput.text,
      );

      return valid != null;
    }
    catch(_){
      return null;
    }
  }

  _checkFingerPrint() async {
    if(await fingerPrintAuth.canCheckBiometrics && (sharedPreferences.getBool("finger_print_change_password") ?? false)){
      var authenticate = await fingerPrintAuth.authenticate(
        localizedReason: "Utilize a sua digital para redefinir a sua senha.",
      );

      return authenticate;
    }
    return true;
  }

  resetPasswordButtonPressed() async {
    try{
      if(formKey.currentState!.validate()){
        resetPasswordButtonFocusNode.requestFocus();

        if(oldPasswordInput.text == newPasswordInput.text) {
          await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const InformationPopup(
                warningMessage: "A nova senha não pode ser igual a senha atual!",
              );
            },
          );
        }
        else if(await _checkFingerPrint()){
          await loadingWithSuccessOrErrorWidget.startAnimation();
          await Future.delayed(const Duration(milliseconds: 500));
          if(await InternetConnection.checkConnection()){
            bool? valid = resetFromForgetPassword;
            if(!valid) valid = await _validPasswordReset();

            if(valid ?? false){
              if((!resetFromForgetPassword && await _userService.forgetPasswordInternal(newPasswordInput.text)) ||
                  (resetFromForgetPassword && forgetPasswordResponse != null && await _userService.forgetPasswordWithId(forgetPasswordResponse!.userId, newPasswordInput.text))){
                await loadingWithSuccessOrErrorWidget.stopAnimation();
                await showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return InformationPopup(
                      success: true,
                      warningMessage: "Senha alterada com sucesso!${!resetFromForgetPassword ? "\nNecessário refazer o login." : ""}",
                    );
                  },
                );

                await UserInformation.deleteOptions();
                await Get.offAll(() => const LoginPage());
                return;
              }
              else {
                throw Exception();
              }
            }
            else if(valid == null) {
              throw Exception();
            }
            else if(!resetFromForgetPassword) {
              await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
              showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const InformationPopup(
                    warningMessage: "A senha atual está incorreta!",
                  );
                },
              );
            }
          }
          else{
            await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
            showDialog(
              context: Get.context!,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const InformationPopup(
                  warningMessage: "É necessário uma conexão com a internet para redefinir a senha.",
                );
              },
            );
          }
        }
      }
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Ocorreu um erro durante a redefinição da nova senha.",
          );
        },
      );
    }
  }
}