import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import 'app.dart';
import 'app/enums/enums.dart';
import 'app/utils/stylePages/app_colors.dart';
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
  runApp(App(color: colorCustom));
  initOneSignal();
}

void initOneSignal() async {
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("8076b26d-54e3-42ca-97cc-cbdddcca9694");
  if(! await OneSignal.shared.userProvidedPrivacyConsent()) OneSignal.shared.promptUserForPushNotificationPermission();

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {

  });

  var status = await OneSignal.shared.getDeviceState();
  LoggedUser.playerId = status != null ? status.userId ?? "" : "";
}