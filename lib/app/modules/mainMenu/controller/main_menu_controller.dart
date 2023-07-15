import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zi_partner/app/modules/findPeople/page/find_people_page.dart';
import 'package:zi_partner/app/utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../matchs/page/matchs_page.dart';
import '../../profile/page/profile_page.dart';

class MainMenuController extends GetxController {
  final bool goToSecondTab;
  late TabController tabController;
  late List<Widget> tabMainMenuList;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late SharedPreferences sharedPreferences;

  MainMenuController(this.goToSecondTab) {
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(goToSecondTab) tabController.animateTo(1, duration: const Duration(seconds: 0));
    super.onInit();
  }

  _initializeVariables(){
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();

    tabMainMenuList = [
      const FindPeoplePage(),
      const MatchsPage(),
      const ProfilePage(),
    ];
  }
}
