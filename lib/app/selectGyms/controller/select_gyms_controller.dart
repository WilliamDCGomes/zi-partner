import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/models/gym/gym.dart';
import '../../../base/services/gym_service.dart';
import '../../../base/services/interfaces/igym_service.dart';
import '../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';

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
      _selectGymsAlreadySelected();
      update(["gyms-list"]);
      await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    }
    catch(_) {
      gyms.clear();
    }
  }

  filterGymsByName() async {
    try {
      if(gymsName.text.isNotEmpty) {
        gyms.clear();
        gyms.value = (await _gymService.getGymsByName(gymsName.text) ?? <Gym>[]);
        gyms.sort((a, b) => a.name.compareTo(b.name));
        _selectGymsAlreadySelected();
        update(["gyms-list"]);
      }
    }
    catch(_) {
      gyms.clear();
    }
  }

  _selectGymsAlreadySelected() {
    for(var gym in selectedGyms) {
      for(var secondGym in gyms) {
        if(secondGym.id == gym.id) {
          secondGym.selected = true;
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

  addGymToList(String gymName) async {
    final newGym = Gym(
      name: gymName,
      selected: true,
    );
    if (gymName.isNotEmpty && await _gymService.createGym(newGym)) {
      gyms.add(newGym);
      gyms.sort((a, b) => a.name.compareTo(b.name));
      update(["gyms-list"]);
    }
    gyms.refresh();
    Get.back();
  }
}
