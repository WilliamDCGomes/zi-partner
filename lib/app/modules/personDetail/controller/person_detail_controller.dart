import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import 'package:zi_partner/base/services/match_or_dislike_service.dart';
import '../../../../base/models/matchOrDislike/match_or_dislike.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/imatch_or_dislike_service.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../findPeople/controller/find_people_controller.dart';
import '../../mainMenu/page/main_menu_page.dart';

class PersonDetailController extends GetxController {
  late bool _animationInitialized;
  late Person person;
  late ScrollController aboutMeScrollController;
  late FindPeopleController _findPeopleController;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IMatchOrDislikeService _matchOrDislikeService;

  PersonDetailController(this.person) {
    _initializeVariables();
  }

  _initializeVariables() {
    _animationInitialized = false;
    aboutMeScrollController = ScrollController();
    _findPeopleController = Get.find(tag: "find-people-controller");
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _matchOrDislikeService = MatchOrDislikeService();
  }
  
  reactPerson(bool approved, String userName) async {
    try {
      if(!_animationInitialized) {
        await loadingWithSuccessOrErrorWidget.startAnimation();
        _animationInitialized = true;
      }
      await _findPeopleController.reactPerson(approved, userName, disableLoad: true);
      if(_animationInitialized) {
        _animationInitialized = false;
        await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
      }
      Get.back();
    }
    catch(_) {
      if(_animationInitialized) {
        _animationInitialized = false;
        await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      }
    }
  }
  
  deleteMatch() async {
    try {
      bool deleteMatchWithUser = false;
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return ConfirmationPopup(
            title: "Aviso",
            subTitle: "Tem certeza que deseja desfazer o match com ${person.name}?\nVocê irá perder todas as mensagens com essa pessoa e ela não aparecerá mais na sua lista para realizar um novo match!",
            firstButton: () {},
            secondButton: () => deleteMatchWithUser = true,
          );
        },
      );
      
      if(deleteMatchWithUser) {
        await loadingWithSuccessOrErrorWidget.startAnimation();
        
        if(!await _matchOrDislikeService.removeMatchOrDislike(
          MatchOrDislike(
            userId: LoggedUser.id,
            otherUserId: person.id,
            isMatch: true,
          ))) {
          throw Exception();
        }

        await loadingWithSuccessOrErrorWidget.stopAnimation();
        await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return InformationPopup(
              success: true,
              warningMessage: "Você desfez o match com ${person.name}.\nTodas as mensagens entre vocês foram apagadas, em ambas as contas!",
            );
          },
        );
        Get.offAll(const MainMenuPage(goToSecondTab: true,));
      }
    }
    catch(_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InformationPopup(
            warningMessage: "Erro ao desfazer o match com ${person.name}.\nTente novamente mais tarde!",
          );
        },
      );
    }
  }
}
