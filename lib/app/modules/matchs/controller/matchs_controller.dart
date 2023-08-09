import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/services/match_or_dislike_service.dart';
import '../../../../base/models/message/message.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/imatch_or_dislike_service.dart';
import '../../../../base/services/interfaces/imessage_service.dart';
import '../../../../base/services/message_service.dart';
import '../../mainMenu/controller/main_menu_controller.dart';

class MatchsController extends GetxController {
  late bool _allUsersGet;
  late bool _canUpdate;
  late bool _animationInitialized;
  late RxList<Person> matchsList;
  late ScrollController scrollController;
  late MainMenuController _mainMenuController;
  late IMessageService _messageService;
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
    _searchNewMessages();
    super.onInit();
  }

  _initializeVariables() {
    _allUsersGet = false;
    _canUpdate = true;
    _animationInitialized = false;
    matchsList = <Person>[].obs;
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getNext7Match();
      }
    });
    _messageService = MessageService();
    _matchOrDislikeService = MatchOrDislikeService();
  }

  _searchNewMessages() async {
    try {
      while(_canUpdate) {
        await Future.delayed(const Duration(seconds: 2));

        for(var match in matchsList) {
          var message = await _messageService.getLastNewMessages(match.id);

          if(message != null && (match.lastMessage == null || match.lastMessage!.alteration!.compareTo(message.alteration!) < 0)) {
            message.setMessageDate();
            refreshLastMessage(message);
          }
        }
      }
    }
    catch(_) {

    }
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
        _orderList();
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
    try {
      matchsList.firstWhere((element) => element.id == message.receiverId || element.id == message.userId).lastMessage = message;
      _orderList();

      matchsList.refresh();
      update(['matchs-list']);
    }
    catch(_) {

    }
  }

  _orderList() {
    var withMessages = matchsList.where((match) => match.lastMessage != null).toList();
    var withoutMessages = matchsList.where((match) => match.lastMessage == null).toList();
    if(withMessages.isNotEmpty) {
      withMessages.sort((a, b) => b.lastMessage!.alteration.toString().compareTo(a.lastMessage!.alteration.toString()));
      withMessages.sort((a, b) => a.lastMessage!.read.toString().compareTo(b.lastMessage!.read.toString()));
    }
    matchsList.clear();
    matchsList.addAll(withMessages);
    matchsList.addAll(withoutMessages);
  }
}
