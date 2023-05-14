import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zi_partner/app/modules/findPeople/page/find_people_page.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import '../../../enums/enums.dart';
import '../../matchs/page/matchs_page.dart';
import '../../profile/page/profile_page.dart';

class MainMenuController extends GetxController {
  late TabController tabController;
  late List<Widget> tabMainMenuList;
  late SharedPreferences sharedPreferences;

  MainMenuController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("user_logged", "Rafes");
    await sharedPreferences.setString("password", "123456");
    super.onInit();
  }

  _initializeVariables(){
    LoggedUser.name = "Rafael Torres Alváres";
    LoggedUser.birthdate = "20/04/1996";
    LoggedUser.gender = TypeGender.masculine;
    LoggedUser.cep = "00000-000";
    LoggedUser.uf = "SP";
    LoggedUser.city = "São Paulo";
    LoggedUser.street = "Avenida Paulista";
    LoggedUser.houseNumber = "4-4";
    LoggedUser.neighborhood = "Avenida Paulista";
    LoggedUser.cellPhone = "99999-9999";
    LoggedUser.email = "teste@teste.com";

    tabMainMenuList = [
      const FindPeoplePage(),
      const MatchsPage(),
      const ProfilePage(),
    ];
  }
}
