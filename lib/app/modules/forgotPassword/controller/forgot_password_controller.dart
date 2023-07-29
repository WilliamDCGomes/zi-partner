import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/services/user_service.dart';
import '../../../../base/viewControllers/forgetPasswordResponse/forget_password_response.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../forgotPasswordInsertCode/page/forgot_password_insert_code_page.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailInputController;
  late RxBool emailInputHasError;
  late final GlobalKey<FormState> formKey;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IUserService _userService;

  ForgotPasswordController(){
    _inicializeVariables();
  }

  _inicializeVariables(){
    emailInputController = TextEditingController();
    emailInputHasError = false.obs;
    formKey = GlobalKey<FormState>();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _userService = UserService();
  }

  sendButtonPressed() async {
    try{
      if(formKey.currentState!.validate()){
        await loadingWithSuccessOrErrorWidget.startAnimation();
        var response = await _userService.forgetPassword(emailInputController.text);

        if(response == null) throw Exception();
        if(!await _validResponse(response)) return;

        await loadingWithSuccessOrErrorWidget.stopAnimation();
        await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const InformationPopup(
              success: true,
              warningMessage: "Um código de validação foi enviado para o E-mail informado.\nPor favor, utilize ele para redefinir a senha na próxima tela.",
            );
          },
        );
        Get.to(() => ForgotPasswordInsertCodePage(
          userEmail: emailInputController.text,
        ));
      }
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

  Future<bool> _validResponse(ForgetPasswordResponse forgetPasswordResponse) async {
    try {
      if(!forgetPasswordResponse.success) {
        await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
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