import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/services/user_service.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../login/page/login_page.dart';

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
        /*if(await _userService.resetPassword(emailInputController.text)){
          await loadingWithSuccessOrErrorWidget.stopAnimation();
          await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const InformationPopup(
                warningMessage: "Enviamos em seu E-mail as instruções para recuperar sua conta.",
              );
            },
          );
          await Get.offAll(() => const LoginPage());
        }*/
        throw Exception();
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
}