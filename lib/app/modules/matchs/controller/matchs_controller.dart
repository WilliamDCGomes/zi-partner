import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/services/match_or_dislike_service.dart';
import '../../../../base/models/message/message.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/imatch_or_dislike_service.dart';
import '../../mainMenu/controller/main_menu_controller.dart';

class MatchsController extends GetxController {
  late bool _allUsersGet;
  late bool _animationInitialized;
  late RxList<Person> matchsList;
  late ScrollController scrollController;
  late MainMenuController _mainMenuController;
  late IMatchOrDislikeService _matchOrDislikeService;

  MatchsController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    _mainMenuController = Get.find(tag: 'main-menu-controller');
    await Future.delayed(const Duration(milliseconds: 200));
    await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
    _animationInitialized = true;
    await getNext7Match();
    super.onInit();
  }

  _initializeVariables() {
    _allUsersGet = false;
    _animationInitialized = false;
    matchsList = <Person>[].obs;
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getNext7Match();
      }
    });
    _matchOrDislikeService = MatchOrDislikeService();
  }

  getNext7Match({bool ignoreLimitation = false}) async {
    try {
      if(!_allUsersGet || ignoreLimitation) {
        if(!_animationInitialized) {
          await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
          _animationInitialized = true;
        }
        var people = await _matchOrDislikeService.getNext7PeopleFromMatchs(matchsList.length);

        if(people != null && people.isNotEmpty) {
          _allUsersGet = people.length < 6;
          for(var person in people) {
            if(!matchsList.any((x) => x.userName == person.userName)) matchsList.add(person);
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

  refreshLastMessage(Messages message) {
    matchsList.firstWhere((element) => element.id == message.receiverId).lastMessage = message;
    matchsList.refresh();
  }
}
