import 'package:get/get.dart';
import 'package:zi_partner/base/services/user_service.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/iuser_service.dart';
import '../../mainMenu/controller/main_menu_controller.dart';

class FindPeopleController extends GetxController {
  late RxList<Person> peopleList;
  late IUserService _userService;
  late MainMenuController _mainMenuController;

  FindPeopleController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    _mainMenuController = Get.find(tag: 'main-menu-controller');
    await Future.delayed(const Duration(milliseconds: 200));
    await getNextFivePeople();
    super.onInit();
  }

  _initializeVariables(){
    _userService = UserService();
    peopleList = <Person>[].obs;
    peopleList.sort((a, b) => a.distance.compareTo(b.distance));
  }

  getNextFivePeople() async {
    try {
      await _mainMenuController.loadingWithSuccessOrErrorWidget.startAnimation();
      var people = await _userService.getNextFiveUsers((peopleList.length / 5).floor());

      if(people != null && people.isNotEmpty) {
        peopleList.addAll(people);
      }
    }
    catch(_) {}
    finally {
      await _mainMenuController.loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    }
  }
}
