import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/services/interfaces/iuser_service.dart';
import '../sharedWidgets/popups/information_popup.dart';

class GetProfilePictureController {
  static loadProfilePicture(RxBool loadingPicture, RxBool hasPicture, RxString profileImagePath, IUserService userService) async {
    try{
      loadingPicture.value = true;
      profileImagePath.value = await userService.getUserProfilePicture();
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