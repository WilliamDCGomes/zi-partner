import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../sharedWidgets/loading_with_success_or_error_widget.dart';

class Loading{
  static Future startAndPauseLoading(Function action, LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await loadingWithSuccessOrErrorWidget.startAnimation();

    await Future.delayed(const Duration(seconds: 1));
    await action();

    await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
  }

  static Future starAnimationAndCallOtherPage(
      Function action,
      LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget,
      Widget destinationPage,
  ) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    await loadingWithSuccessOrErrorWidget.startAnimation();

    await Future.delayed(const Duration(seconds: 1));
    await action();

    await loadingWithSuccessOrErrorWidget.stopAnimation(
      destinationPage: destinationPage
    );
  }
}