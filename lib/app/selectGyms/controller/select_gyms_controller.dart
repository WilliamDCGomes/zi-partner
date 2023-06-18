import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/models/gym/gym.dart';
import '../../../base/services/gym_service.dart';
import '../../../base/services/interfaces/igym_service.dart';
import '../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../popup/gym_popup.dart';

class SelectGymsController extends GetxController {
  late RxBool allGymsSelected;
  late RxList<Gym> gyms;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late final IGymService _gymService;

  SelectGymsController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await getAllGyms();
    super.onInit();
  }

  _initializeVariables() {
    allGymsSelected = false.obs;
    gyms = <Gym>[].obs;
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _gymService = GymService();
  }

  getAllGyms() async {
    try {
      await loadingWithSuccessOrErrorWidget.startAnimation();
      gyms.clear();
      gyms.value = (await _gymService.getAllGyms() ?? <Gym>[]);
      gyms.sort((a, b) => a.name.compareTo(b.name));
      update(["gyms-list"]);
      await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    }
    catch(_) {
      gyms.clear();
    }
  }

  selectAllCategories() {
    allGymsSelected.value = !allGymsSelected.value;

    for (var gym in gyms) {
      gym.selected = allGymsSelected.value;
    }

    update(["gyms-list"]);
  }

  saveGyms() {
    Get.back(result: gyms.where((gym) => gym.selected).toList());
  }

  addNewGym() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GymPopup();
      },
    );
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
