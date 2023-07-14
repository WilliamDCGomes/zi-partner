import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/services/user_service.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../login/page/login_page.dart';

class ResetPasswordController extends GetxController {
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
  late IUserService _userService;

  ResetPasswordController(){
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
            var valid = await _validPasswordReset();

            if(valid ?? false){
              if(await _userService.forgetPasswordInternal(newPasswordInput.text)){
                await loadingWithSuccessOrErrorWidget.stopAnimation();
                await showDialog(
                  context: Get.context!,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const InformationPopup(
                      warningMessage: "Senha alterada com sucesso!\nNecessário refazer o login.",
                    );
                  },
                );

                await sharedPreferences.setBool("keep-connected", false);
                await sharedPreferences.remove("user_finger_print");
                await Get.offAll(() => const LoginPage());
                return;
              }
            }
            else if(valid == null) {
              throw Exception();
            }
            else{
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