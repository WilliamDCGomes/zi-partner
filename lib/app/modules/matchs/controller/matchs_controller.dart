import 'package:get/get.dart';
import '../../../../base/models/person/person.dart';

class MatchsController extends GetxController {
  late RxList<Person> matchsList;

  MatchsController() {
    _initializeVariables();
  }

  _initializeVariables() {
    matchsList = <Person>[].obs;
  }
}
