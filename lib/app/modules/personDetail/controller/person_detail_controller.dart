import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/models/person/person.dart';

class PersonDetailController extends GetxController {
  late Person person;
  late ScrollController aboutMeScrollController;

  PersonDetailController(this.person) {
    _initializeVariables();
  }

  _initializeVariables() {
    aboutMeScrollController = ScrollController();
  }
}
