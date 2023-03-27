import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sharedWidgets/popups/information_popup.dart';

class GetProfilePictureController {
  static loadProfilePicture(RxBool loadingPicture, RxBool hasPicture, RxString profileImagePath, SharedPreferences sharedPreferences) async {
    try{
      loadingPicture.value = true;
      await Future.delayed(const Duration(milliseconds: 200));
      profileImagePath.value = sharedPreferences.getString("profile_picture") ?? "";
      loadingPicture.value = false;
      hasPicture.value = profileImagePath.value.isNotEmpty;
    }
    catch(_){
      loadingPicture.value = false;
      hasPicture.value = false;
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao atualizar a imagem de perfil.",
          );
        },
      );
    }
  }
}