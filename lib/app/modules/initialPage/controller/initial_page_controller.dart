import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zi_partner/app/utils/helpers/static_informations.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/user_service.dart';
import '../../../../base/viewControllers/authenticateResponse/authenticate_response.dart';
import '../../../utils/helpers/date_format_to_brazil.dart';
import '../../../utils/helpers/save_user_informations.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../login/page/login_page.dart';
import '../../mainMenu/page/main_menu_page.dart';

class InitialPageController extends GetxController {
  late SharedPreferences sharedPreferences;
  late final LocalAuthentication fingerPrintAuth;
  late AuthenticateResponse? userLogged;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late Person? _user;
  late IUserService _userService;

  InitialPageController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    StaticInformations.sharedPreferences = sharedPreferences;
    await _loadFirstScreen();
    super.onInit();
  }

  _initializeVariables() {
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    fingerPrintAuth = LocalAuthentication();
    _user = null;
    _userService = UserService();
  }

  _loadFirstScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (sharedPreferences.getBool("keep-connected") ?? false) {
      if (await fingerPrintAuth.canCheckBiometrics &&
          (sharedPreferences.getBool("always_request_finger_print") ?? false)) {
        var authenticate = await fingerPrintAuth.authenticate(
          localizedReason: "Utilize a sua digital para fazer o login.",
        );

        if (authenticate) {
          await loadingWithSuccessOrErrorWidget.stopAnimation(duration: 2);
          if (!await _doLoginServerKeepConnected()) {
            _resetLogin("Tente fazer o login novamente");
          } else {
            _goToNextPage();
          }
        } else {
          Get.offAll(() => const LoginPage(cancelFingerPrint: true,));
        }
      } else {
        if (!await _doLoginServerKeepConnected()) {
          _resetLogin("Tente fazer o login novamente");
        } else {
          _goToNextPage();
        }
      }
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  _goToNextPage() {
    Get.offAll(() => const MainMenuPage());
  }

  Future<bool> _doLoginServerKeepConnected() async {
    try {
      LoggedUser.fullName = sharedPreferences.getString("user_name_and_last_name") ?? "";
      LoggedUser.name = sharedPreferences.getString(
        "name",
      ) ?? "";
      LoggedUser.id = sharedPreferences.getString("user_id") ?? "";
      var result = await _doLoginServer();

      if(result) {
        if(!await UserInformation.saveOptions(_user)){
          throw Exception();
        }
      }

      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> _doLoginServer() async {
    try {
      String? username = sharedPreferences.getString("user_name");
      String? password = sharedPreferences.getString("password");

      if (username == null || password == null) {
        await _resetLogin("Erro ao se autenticar com a digital.\nPor favor, utilize o login e a senha para continuar.");
        return false;
      }

      userLogged = await _userService
          .authenticate(
            username: username,
            password: password,
          )
          .timeout(const Duration(seconds: 30));

      if (userLogged?.success == false) {
        await _resetLogin("Usuário e/ou senha incorretos");
        return false;
      }

      await sharedPreferences.setString('Token', userLogged!.token!);
      await sharedPreferences.setString('ExpiracaoToken', DateFormatToBrazil.formatDateAmerican(userLogged!.expirationDate));
      _user = await _userService.getUserInformation(username);
      return true;
    } catch (e) {
      await _resetLogin("Erro ao se conectar com o servidor.");
      return false;
    }
  }

  _resetLogin(String message) async {
    await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return InformationPopup(
          warningMessage: message,
        );
      },
    );
    Get.offAll(const LoginPage(
      cancelFingerPrint: true,
    ));
  }
}
