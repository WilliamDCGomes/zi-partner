import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/models/gym/gym.dart';
import '../../../base/services/gym_service.dart';
import '../../../base/services/interfaces/igym_service.dart';
import '../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../utils/sharedWidgets/popups/information_popup.dart';

class SelectGymsController extends GetxController {
  late RxList<Gym> gyms;
  late List<Gym> selectedGyms;
  late TextEditingController gymsName;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late final IGymService _gymService;

  SelectGymsController(this.selectedGyms) {
    _initializeVariables();
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _get10FirstGyms();
    super.onInit();
  }

  _initializeVariables() {
    gyms = <Gym>[].obs;
    gymsName = TextEditingController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _gymService = GymService();
  }

  _get10FirstGyms() async {
    try {
      await loadingWithSuccessOrErrorWidget.startAnimation();
      gyms.clear();
      gyms.value = (await _gymService.get10FirstGyms() ?? <Gym>[]);
      gyms.sort((a, b) => a.name.compareTo(b.name));
      await _selectGymsAlreadySelected();
      update(["gyms-list"]);
      await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    }
    catch(_) {
      gyms.clear();
    }
  }

  filterGymsByName() async {
    try {
      update(["button-add-new-gym"]);
      if(gymsName.text.isNotEmpty) {
        gyms.clear();
        gyms.value = (await _gymService.getGymsByName(gymsName.text) ?? <Gym>[]);
        gyms.sort((a, b) => a.name.compareTo(b.name));
        await _selectGymsAlreadySelected(filterPerName: true);
        update(["gyms-list"]);
      }
    }
    catch(_) {
      gyms.clear();
    }
  }

  _selectGymsAlreadySelected({bool filterPerName = false}) async {
    for(var gym in selectedGyms) {
      if(gym.id != null && gym.id!.isNotEmpty && !gyms.any((element) => element.id == gym.id) && !await _gymService.checkIfGymExist(gym.id!)) {
        if(filterPerName && gym.name.trim().toLowerCase().contains(gymsName.text.trim().toLowerCase())) {
          gyms.add(gym);
        }
        else if(!filterPerName){
          gyms.add(gym);
        }
      }
      else{
        for(var secondGym in gyms) {
          if(secondGym.id == gym.id) {
            secondGym.selected = true;
            break;
          }
        }
      }
    }
  }

  saveGyms() {
    Get.back(result: selectedGyms);
  }

  selectGym(int index) {
    gyms[index].selected = !gyms[index].selected;

    if(gyms[index].selected) {
      selectedGyms.add(gyms[index]);
    }
    else if(selectedGyms.any((gym) => gym.id == gyms[index].id)) {
      selectedGyms.removeWhere((gym) => gym.id == gyms[index].id);
    }
  }

  addGymToList() async {
    if (gymsName.text.isNotEmpty) {
      if(selectedGyms.any((gym) => gym.name.trim().toLowerCase() == gymsName.text.trim().toLowerCase()) || await _gymService.checkIfGymExistByName(gymsName.text)) {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return const InformationPopup(
              warningMessage: "Essa academia já está cadastrada no sistema!\nPor favor, selecione ela ao invés de adicionar novamente.",
            );
          },
        );
      }
      else {
        final newGym = Gym(
          name: gymsName.text,
          selected: true,
        );
        await _get10FirstGyms();
        gyms.add(newGym);
        selectedGyms.add(newGym);
        gyms.sort((a, b) => a.name.compareTo(b.name));
        gymsName.clear();
        update(["gyms-list"]);
      }
    }
  }
}
