import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../findPeople/controller/find_people_controller.dart';

class PersonDetailController extends GetxController {
  late bool _animationInitialized;
  late Person person;
  late ScrollController aboutMeScrollController;
  late FindPeopleController _findPeopleController;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;

  PersonDetailController(this.person) {
    _initializeVariables();
  }

  _initializeVariables() {
    _animationInitialized = false;
    aboutMeScrollController = ScrollController();
    _findPeopleController = Get.find(tag: "find-people-controller");
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
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
}
