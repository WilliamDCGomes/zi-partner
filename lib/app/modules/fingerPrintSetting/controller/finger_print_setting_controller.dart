import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';

class FingerPrintSettingController extends GetxController {
  late RxBool loadingAnimation;
  late RxBool fingerPrintLoginChecked;
  late RxBool alwaysRequestFingerPrintChecked;
  late RxBool enableAlwaysRequestFingerPrint;
  late RxBool fingerPrintChangePasswordChecked;
  late FocusNode saveButtonFocusNode;
  late SharedPreferences sharedPreferences;
  late final LocalAuthentication fingerPrintAuth;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;

  FingerPrintSettingController(){
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _getSettingsFingerPrint();
    super.onInit();
  }

  _initializeVariables(){
    fingerPrintLoginChecked = false.obs;
    alwaysRequestFingerPrintChecked = false.obs;
    enableAlwaysRequestFingerPrint = true.obs;
    fingerPrintChangePasswordChecked = false.obs;
    loadingAnimation = false.obs;
    saveButtonFocusNode = FocusNode();

    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    fingerPrintAuth = LocalAuthentication();
  }

  _getSettingsFingerPrint() {
    fingerPrintLoginChecked.value = sharedPreferences.getBool("user_finger_print") ?? false;
    alwaysRequestFingerPrintChecked.value = sharedPreferences.getBool("always_request_finger_print") ?? false;
    fingerPrintChangePasswordChecked.value = sharedPreferences.getBool("finger_print_change_password") ?? false;

    enableAlwaysRequestFingerPrint.value = !fingerPrintLoginChecked.value;
  }

  fingerPrintLoginPressed(){
    fingerPrintLoginChecked.value = !fingerPrintLoginChecked.value;
    if(!fingerPrintLoginChecked.value){
      alwaysRequestFingerPrintChecked.value = false;
      enableAlwaysRequestFingerPrint.value = true;
    }
    else{
      enableAlwaysRequestFingerPrint.value = false;
    }
  }

  alwaysRequestFingerPrintPressed(){
    alwaysRequestFingerPrintChecked.value = !alwaysRequestFingerPrintChecked.value;
  }

  fingerPrintChangePasswordPressed(){
    fingerPrintChangePasswordChecked.value = !fingerPrintChangePasswordChecked.value;
  }

  _checkFingerPrint() async {
    if(await fingerPrintAuth.canCheckBiometrics){
      var authenticate = await fingerPrintAuth.authenticate(
        localizedReason: "Utilize a sua digital para salvar as configurações.",
      );

      return authenticate;
    }
    return true;
  }

  saveButtonPressed() async {
    try{
      if(await _checkFingerPrint()){
        loadingAnimation.value = true;
        await loadingWithSuccessOrErrorWidget.startAnimation();
        await sharedPreferences.setBool("user_finger_print", fingerPrintLoginChecked.value);
        await sharedPreferences.setBool("always_request_finger_print", alwaysRequestFingerPrintChecked.value);
        await sharedPreferences.setBool("finger_print_change_password", fingerPrintChangePasswordChecked.value);

        await loadingWithSuccessOrErrorWidget.stopAnimation();
        Get.back();
      }
    }
    catch(e){
      print("Erro $e");
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
    }
  }
}