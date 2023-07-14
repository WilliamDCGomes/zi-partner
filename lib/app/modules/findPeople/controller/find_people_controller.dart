import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/models/matchOrDislike/match_or_dislike.dart';
import 'package:zi_partner/base/services/user_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/imatch_or_dislike_service.dart';
import '../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/services/match_or_dislike_service.dart';
import '../../../utils/helpers/send_location.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../mainMenu/controller/main_menu_controller.dart';
import '../../personDetail/page/person_detail_page.dart';

class FindPeopleController extends GetxController {
  late bool allUsersGet;
  late bool _listAlreadyGetAllPeople;
  late bool _animationInitialized;
  late RxList<Person> peopleList;
  late IUserService _userService;
  late MainMenuController _mainMenuController;
  late ScrollController scrollController;
  late IMatchOrDislikeService _matchOrDislikeService;

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
    await getNextFivePeople();
    super.onInit();
  }

  _initializeVariables(){
    allUsersGet = false;
    _animationInitialized = false;
    _listAlreadyGetAllPeople = false;
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getNextFivePeople();
      }
    });
    _userService = UserService();
    peopleList = <Person>[].obs;
    _matchOrDislikeService = MatchOrDislikeService();
  }

  _sendLocation() async {
    if(LoggedUser.id.isNotEmpty) {
      await SendLocation.sendUserLocation(LoggedUser.id);
    }
  }

  getNextFivePeople({bool ignoreLimitation = false}) async {
    try {
      if(!allUsersGet || ignoreLimitation) {
        if(!_animationInitialized) {
          await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
          _animationInitialized = true;
        }
        var people = await _userService.getNextFiveUsers(peopleList.length);

        if(people != null && people.isNotEmpty) {
          allUsersGet = people.length < 5;
          for(var person in people) {
            if(!peopleList.any((x) => x.userName == person.userName)) peopleList.add(person);
          }
        }
        else {
          allUsersGet = true;
        }

        if(allUsersGet && peopleList.isNotEmpty && !_listAlreadyGetAllPeople) {
          _listAlreadyGetAllPeople = true;
          peopleList.add(Person.empty());
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

  openPersonDetail(Person person) async {
    await Get.to(() =>
      PersonDetailPage(person: person),
      duration: const Duration(milliseconds: 700),
    );
    if(peopleList.isEmpty) await getNextFivePeople();
  }

  reactPerson(bool approved, String userName, {bool disableLoad = false}) async {
    try {
      if(!_animationInitialized && !disableLoad) {
        await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
        _animationInitialized = true;
      }
      var person = peopleList.firstWhere((person) => person.userName == userName);

      if(await _matchOrDislikeService.createMatchOrDislike(
        MatchOrDislike(userId: LoggedUser.id, otherUserId: person.id, isMatch: approved),
      )) {
        peopleList.remove(person);
        if(peopleList.isEmpty) await getNextFivePeople();
      }
      if(_animationInitialized && !disableLoad) {
        _animationInitialized = false;
        await _mainMenuController.loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
      }
      if(approved && await _matchOrDislikeService.checkIfItsAMatch(LoggedUser.id, person.id)){
        await showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const InformationPopup(
              success: true,
              warningMessage: "Opaa, é um MATCH!!\nComece agora mesmo a treinar.",
            );
          },
        );
      }
    }
    catch(_) {
      if(_animationInitialized && !disableLoad) {
        _animationInitialized = false;
        await _mainMenuController.loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      }
    }
  }
}
