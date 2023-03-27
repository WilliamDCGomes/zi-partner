import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../helpers/paths.dart';
import 'lottie_asset_widget.dart';

class LoadingProfilePictureWidget extends StatefulWidget {
  late final RxBool loadingAnimation;
  late final RxBool isLoading;
  late final AnimationController animationController;

  LoadingProfilePictureWidget(
      { Key? key,
        RxBool? internalLoadingAnimation,
      }) : super(key: key){
    isLoading = true.obs;
    loadingAnimation = internalLoadingAnimation ?? false.obs;
  }

  @override
  State<LoadingProfilePictureWidget> createState() => _LoadingProfilePictureWidgetState();

  Future startAnimation({Widget? destinationPage, bool? backPage}) async {
    loadingAnimation.value = true;
    animationController.repeat();
  }

  Future stopAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    _resetState();
    return;
  }

  _resetState(){
    loadingAnimation.value = false;
    isLoading.value = true;
    animationController.reset();
  }
}

class _LoadingProfilePictureWidgetState extends State<LoadingProfilePictureWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.animationController = AnimationController(vsync: this);
    widget.animationController.duration = const Duration(seconds: 3);
    super.initState();
  }

  @override
  void dispose() {
    widget.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !widget.loadingAnimation.value;
      },
      child: Obx(
        () => Visibility(
          visible: widget.loadingAnimation.value,
          child: Center(
            child: LottieAssetWidget(
              height: 40.h,
              width: 40.h,
              animationPath: Paths.loading,
              animationController: widget.animationController,
            ),
          ),
        ),
      ),
    );
  }
}