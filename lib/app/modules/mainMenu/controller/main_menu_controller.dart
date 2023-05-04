import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/app/modules/findPeople/page/find_people_page.dart';

import '../../matchs/page/matchs_page.dart';

class MainMenuController extends GetxController {
  late TabController tabController;
  late List<Widget> tabMainMenuList;

  MainMenuController() {
    _initializeVariables();
  }

  _initializeVariables(){
    tabMainMenuList = [
      const FindPeoplePage(),
      const MatchsPage(),
      Container(),
      Container(),
    ];
  }
}
