import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/viewControllers/loggedUser/logged_user_viewcontroller.dart';
import 'app.dart';
import 'app/enums/enums.dart';
import 'app/utils/helpers/position_util.dart';
import 'app/utils/stylePages/app_colors.dart';
import 'base/viewControllers/userLocation/user_location_view_controller.dart';
import 'flavors.dart';

buildFlavor(Flavor flavor) async {
  F.appFlavor = flavor;
  WidgetsFlutterBinding.ensureInitialized();
  Map<int, Color> color = {
    50: AppColors.defaultColor,
    100: AppColors.defaultColor,
    200: AppColors.defaultColor,
    300: AppColors.defaultColor,
    400: AppColors.defaultColor,
    500: AppColors.defaultColor,
    600: AppColors.defaultColor,
    700: AppColors.defaultColor,
    800: AppColors.defaultColor,
    900: AppColors.defaultColor,
  };
  MaterialColor colorCustom = MaterialColor(0XFFC42404, color);
  sendLocation();
  runApp(App(color: colorCustom));
}

void sendLocation() async {
  if (kDebugMode) return;
  Timer.periodic(const Duration(seconds: 3), (timer) async {
    if (kDebugMode) return;
    try {
      final permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) return;
      final currentLocation = await PositionUtil.determinePosition();
      if (currentLocation == null) return;

      final latitude = currentLocation.latitude.toString();
      final longitude = currentLocation.longitude.toString();
      List<Placemark> placemarks = await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
      if (LoggedUserViewController.id.isEmpty) return;

      final userLocation = UserLocationViewController(
        longitude: longitude,
        latitude: latitude,
        userLocationId: LoggedUserViewController.id,
        address: placemarks.firstWhereOrNull((element) => element.street?.isNotEmpty ?? false)?.street,
        cep: placemarks.firstWhereOrNull((element) => element.postalCode?.isNotEmpty ?? false)?.postalCode,
        city: placemarks.firstWhereOrNull((element) => element.locality?.isNotEmpty ?? false)?.locality ??
            placemarks
                .firstWhereOrNull((element) => element.subAdministrativeArea?.isNotEmpty ?? false)
                ?.subAdministrativeArea,
        district: placemarks.firstWhereOrNull((element) => element.subLocality?.isNotEmpty ?? false)?.subLocality,
        uf: placemarks.firstWhereOrNull((element) => element.administrativeArea?.isNotEmpty ?? false)?.administrativeArea,
      );
    } catch (_) {

    }
  });
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}