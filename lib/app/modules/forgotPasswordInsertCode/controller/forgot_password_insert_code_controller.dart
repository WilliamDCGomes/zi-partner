import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zi_partner/app/modules/resetPassword/page/reset_password_page.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/services/user_service.dart';
import '../../../../base/viewControllers/forgetPasswordResponse/forget_password_response.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';

class ForgotPasswordInsertCodeController extends GetxController {
  final String userEmail;
  late RxBool showReSendCode;
  late TextEditingController pinPutEmailController;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IUserService _userService;

  ForgotPasswordInsertCodeController(this.userEmail){
    _inicializeVariables();
  }

  _inicializeVariables(){
    showReSendCode = false.obs;
    pinPutEmailController = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _userService = UserService();
  }

  sendButtonPressed() async {
    try{
      if(!_validCodeTyped()) return;
      await loadingWithSuccessOrErrorWidget.startAnimation();
      var response = await _userService.validationForgetPasswordCode(userEmail, pinPutEmailController.text);
      if(response == null) throw Exception();
      if(!await _validResponse(response)) return;

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      Get.offAll(() => ResetPasswordPage(
        resetFromForgetPassword: true,
        forgetPasswordResponse: response,
      ));
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro durante a validação do código!\nTente novamente mais tarde.",
          );
        },
      );
    }
  }

  reSendButtonPressed() async {
    try{
      await loadingWithSuccessOrErrorWidget.startAnimation();
      var response = await _userService.forgetPassword(userEmail);

      if(response == null) throw Exception();
      if(!await _validResponse(response)) return;

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            success: true,
            warningMessage: "Um novo código de validação foi enviado para o E-mail informado.\nPor favor, utilize ele para redefinir a senha.",
          );
        },
      );
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro durante a recuperação!\nTente novamente mais tarde.",
          );
        },
      );
    }
  }

  bool _validCodeTyped() {
    if(pinPutEmailController.text.isEmpty) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Informe o código recebido no E-mail!",
          );
        },
      );
      return false;
    }
    if(pinPutEmailController.text.length < 6) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Informe o código por completo recebido no E-mail!",
          );
        },
      );
      return false;
    }
    if(int.tryParse(pinPutEmailController.text) == null) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "O código informado é inválido!",
          );
        },
      );
      return false;
    }

    return true;
  }

  Future<bool> _validResponse(ForgetPasswordResponse forgetPasswordResponse) async {
    try {
      if(!forgetPasswordResponse.success) {
        await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
        showReSendCode.value = forgetPasswordResponse.errorCode == "102" || forgetPasswordResponse.errorCode == "105";
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return InformationPopup(
              warningMessage: forgetPasswordResponse.errorMessage!,
            );
          },
        );
        return false;
      }

      return true;
    }
    catch(_) {
      throw Exception();
    }
  }
}