import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/models/user/user.dart';
import '../../../../base/services/interfaces/iuser_service.dart';
import '../../../../base/services/user_service.dart';
import '../../../../base/viewControllers/authenticateResponse/authenticate_response.dart';
import '../../../../base/viewControllers/loggedUser/logged_user_viewcontroller.dart';
import '../../../utils/helpers/date_format_to_brazil.dart';
import '../../../utils/helpers/format_numbers.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';

class LoginPageController extends GetxController {
  late bool cancelFingerPrint;
  late RxBool cpfInputHasError;
  late RxBool passwordInputHasError;
  late RxBool passwordFieldEnabled;
  late RxBool keepConected;
  late RxString appVersion;
  late TextEditingController userInputController;
  late TextEditingController passwordInputController;
  late FocusNode passwordInputFocusNode;
  late FocusNode loginButtonFocusNode;
  late SharedPreferences sharedPreferences;
  late final LocalAuthentication fingerPrintAuth;
  late final GlobalKey<FormState> formKey;
  late AuthenticateResponse? userLogged;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IUserService _userService;
  late User? _user;

  LoginPageController(this.cancelFingerPrint) {
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    appVersion.value = (await PackageInfo.fromPlatform()).version;
    userInputController.text = FormatNumbers.stringToCpf(sharedPreferences.getString("user_logged") ?? "");
    if (kDebugMode) {
      passwordInputController.text = "ZiPartner@2023";
    }
    await _getKeepConnected();
    if (!cancelFingerPrint) {
      await _checkBiometricSensor();
    }
    super.onInit();
  }

  _getKeepConnected() {
    keepConected.value = sharedPreferences.getBool("keep-connected") ?? false;
  }

  _initializeVariables() {
    _user = null;
    cpfInputHasError = false.obs;
    passwordInputHasError = false.obs;
    passwordFieldEnabled = true.obs;
    keepConected = false.obs;
    appVersion = "".obs;
    userLogged = null;
    formKey = GlobalKey<FormState>();
    userInputController = TextEditingController();
    passwordInputController = TextEditingController();
    passwordInputFocusNode = FocusNode();
    loginButtonFocusNode = FocusNode();
    fingerPrintAuth = LocalAuthentication();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _userService = UserService();
  }

  _checkBiometricSensor() async {
    try {
      bool? useFingerPrint = sharedPreferences.getBool("user_finger_print");
      if (await fingerPrintAuth.canCheckBiometrics && (useFingerPrint ?? false)) {
        var authenticate = await fingerPrintAuth.authenticate(
          localizedReason: "Utilize a sua digital para fazer o login.",
        );

        if (authenticate) {
          await loadingWithSuccessOrErrorWidget.startAnimation();

          await _doLoginServer(true);
          await _getUserInformations();

          if (userLogged != null) {
            await _saveOptions();

            await loadingWithSuccessOrErrorWidget.stopAnimation();
            _goToNextPage();
          }
        }
      }
    } catch (e) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao fazer Login!\nTente novamente mais tarde.",
          );
        },
      );
    }
  }

  loginPressed() async {
    try {
      if (formKey.currentState!.validate()) {
        await loadingWithSuccessOrErrorWidget.startAnimation();

        if (!await _doLoginServer(false)) {
          return;
        }
        if (!await _getUserInformations()) {
          throw Exception();
        }

        loginButtonFocusNode.requestFocus();

        if (userLogged != null) {
          await _saveOptions();
          await sharedPreferences.setString("password", passwordInputController.text);

          await sharedPreferences.setBool("keep-connected", keepConected.value);

          await loadingWithSuccessOrErrorWidget.stopAnimation();
          _goToNextPage();
        } else {
          await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
          await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const InformationPopup(
                warningMessage: "Usuário ou a Senha estão incorreto.",
              );
            },
          );
        }
      }
    } catch (_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao fazer Login!\nTente novamente mais tarde.",
          );
        },
      );
    }
  }

  _saveOptions() async {
    String? oldUser = sharedPreferences.getString("user_logged");
    if (oldUser == null) {
      await sharedPreferences.setString("user_logged", userInputController.text.replaceAll('.', '').replaceAll('-', ''));
    } else if (oldUser != userInputController.text.replaceAll('.', '').replaceAll('-', '')) {
      await sharedPreferences.remove("user_finger_print");
      await sharedPreferences.setString("user_logged", userInputController.text.replaceAll('.', '').replaceAll('-', ''));
    }

    await sharedPreferences.setBool("keep-connected", keepConected.value);

    if (_user != null) {
      await sharedPreferences.setString("name", _user!.name);
      await sharedPreferences.setString("birthdate", DateFormatToBrazil.formatDate(_user!.birthdayDate));
      await sharedPreferences.setString("balanceMoney", _user!.balanceMoney.toString());
      await sharedPreferences.setString("pouchLastUpdate", _user!.pouchLastUpdate.toString());
      await sharedPreferences.setString("balanceStuffedAnimals", _user!.balanceStuffedAnimals.toString());
      await sharedPreferences.setString("stuffedAnimalsLastUpdate", _user!.stuffedAnimalsLastUpdate.toString());
      switch (_user!.gender) {
        case TypeGender.masculine:
          await sharedPreferences.setString("gender", "Masculino");
          LoggedUserViewController.gender = "Masculino";
          break;
        case TypeGender.feminine:
          await sharedPreferences.setString("gender", "Feminino");
          LoggedUserViewController.gender = "Feminino";
          break;
        case TypeGender.other:
          await sharedPreferences.setString("gender", "Outro");
          LoggedUserViewController.gender = "Outro";
          break;
        case TypeGender.none:
          await sharedPreferences.setString("gender", "Não Informado");
          LoggedUserViewController.gender = "Não Informado";
          break;
      }
      await sharedPreferences.setString("cpf", _user!.document ?? "");
      await sharedPreferences.setString("cep", _user!.cep ?? "");
      await sharedPreferences.setString("city", _user!.city ?? "");
      await sharedPreferences.setString("street", _user!.address ?? "");
      await sharedPreferences.setString("houseNumber", _user!.number ?? "");
      await sharedPreferences.setString("neighborhood", _user!.district ?? "");
      await sharedPreferences.setString("complement", _user!.complement ?? "");
      await sharedPreferences.setString("phone", _user!.tellphone ?? "");
      await sharedPreferences.setString("cellPhone", _user!.cellphone ?? "");
      await sharedPreferences.setString("email", _user!.email ?? "");
      await sharedPreferences.setString("uf", _user!.uf ?? "");
      await sharedPreferences.setString("code", _user!.code.toString());
      LoggedUserViewController.birthdate = DateFormatToBrazil.formatDate(_user!.birthdayDate);
      LoggedUserViewController.cpf = _user!.document ?? "";
      LoggedUserViewController.cep = _user!.cep ?? "";
      LoggedUserViewController.city = _user!.city ?? "";
      LoggedUserViewController.street = _user!.address ?? "";
      LoggedUserViewController.houseNumber = _user!.number ?? "";
      LoggedUserViewController.neighborhood = _user!.district ?? "";
      LoggedUserViewController.complement = _user!.complement ?? "";
      LoggedUserViewController.phone = _user!.tellphone ?? "";
      LoggedUserViewController.cellPhone = _user!.cellphone ?? "";
      LoggedUserViewController.email = _user!.email ?? "";
      LoggedUserViewController.uf = _user!.uf ?? "";
    }

    if (userLogged != null) {
      LoggedUserViewController.nameAndLastName = userLogged!.name!;
      LoggedUserViewController.name = userLogged!.name!.split(' ').first;
      LoggedUserViewController.id = userLogged!.id!;
      LoggedUserViewController.password = passwordInputController.text;

      await sharedPreferences.setString("user_name_and_last_name", userLogged!.name!);
      await sharedPreferences.setString("user_name", userLogged!.name!.split(' ').first);
      await sharedPreferences.setString("user_id", userLogged!.id!);
    }
  }

  Future<bool> _doLoginServer(bool fromBiometric) async {
    try {
      String? username = "";
      String? password = "";

      if (fromBiometric) {
        username = sharedPreferences.getString("user_logged");
        password = sharedPreferences.getString("password");

        if (username == null || password == null) {
          await _resetLogin("Erro ao se autenticar com a digital.\nPor favor, utilize o login e a senha para continuar.");
          return false;
        }
      }
      if (await InternetConnection.checkConnection()) {
        userLogged = await _userService
            .authenticate(
              username: fromBiometric
                  ? username
                  : userInputController.text.replaceAll('.', '').replaceAll('-', '').toLowerCase().trim(),
              password: fromBiometric ? password : passwordInputController.text.trim(),
            );
        if (!fromBiometric) {
          await sharedPreferences.setString("password", passwordInputController.text);
        }
        if (userLogged?.success == false) {
          await _resetLogin("Usuário e/ou senha incorretos");
          return false;
        }
        await sharedPreferences.setString('Token', userLogged!.token!);
        await sharedPreferences.setString('ExpiracaoToken', userLogged!.expirationDate!.toIso8601String());
        return true;
      }
      else {
        await _resetLogin("É necessário uma conexão com a internet para fazer login");
        return false;
      }
    } catch (e) {
      await _resetLogin("Erro ao se conectar com o servidor.");
      return false;
    }
  }

  Future<bool> _getUserInformations() async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  _goToNextPage() async {

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
  }
}
