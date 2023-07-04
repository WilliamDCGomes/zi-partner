import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/services/user_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/iuser_service.dart';
import '../../../utils/helpers/send_location.dart';
import '../../mainMenu/controller/main_menu_controller.dart';

class FindPeopleController extends GetxController {
  late bool _allUsersGet;
  late bool _animationInitialized;
  late RxList<Person> peopleList;
  late IUserService _userService;
  late MainMenuController _mainMenuController;
  late ScrollController scrollController;

  FindPeopleController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    _mainMenuController = Get.find(tag: 'main-menu-controller');
    await Future.delayed(const Duration(milliseconds: 200));
    await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
    _animationInitialized = true;
    await _sendLocation();
    await _getNextFivePeople();
    super.onInit();
  }

  _initializeVariables(){
    _allUsersGet = false;
    _animationInitialized = false;
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _getNextFivePeople();
      }
    });
    _userService = UserService();
    peopleList = <Person>[].obs;
  }

  _sendLocation() async {
    if(LoggedUser.id.isNotEmpty) {
      await SendLocation.sendUserLocation(LoggedUser.id);
    }
  }

  _getNextFivePeople() async {
    try {
      if(!_allUsersGet) {
        if(!_animationInitialized) {
          await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
          _animationInitialized = true;
        }
        var people = await _userService.getNextFiveUsers(peopleList.length);

        if(people != null && people.isNotEmpty) {
          _allUsersGet = people.length < 5;
          for(var person in people) {
            if(!peopleList.any((x) => x.userName == person.userName)) peopleList.add(person);
          }
        }
        else {
          _allUsersGet = true;
        }
      }
    }
    catch(_) {}
    finally {
      if(_animationInitialized) {
        _animationInitialized = false;
        await _mainMenuController.loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
      }
    }
  }
}
