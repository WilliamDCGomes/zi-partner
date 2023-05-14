import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../fingerPrintSetting/page/finger_print_setting_page.dart';
import '../../resetPassword/page/reset_password_page.dart';
import '../widget/card_profile_widget.dart';

class SettingsAppController extends GetxController {
  late SharedPreferences sharedPreferences;
  late final LocalAuthentication fingerPrintAuth;
  late RxList<CardProfileWidget> cardSettingsList;

  SettingsAppController(){
    _initializeVariables();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    fingerPrintAuth = LocalAuthentication();
    if(await fingerPrintAuth.canCheckBiometrics){
      cardSettingsList.add(
        CardProfileWidget(
          iconCard: Image.asset(
            Paths.iconeConfiguracaoBiometria,
            height: 4.5.h,
            width: 4.5.h,
            color: AppColors.defaultColor,
          ),
          titleIconPath: "Configuração da Digital",
          onTap: () => Get.to(() => const FingerPrintSettingPage()),
        ),
      );
    }
    super.onInit();
  }

  _initializeVariables(){
    cardSettingsList = [
      CardProfileWidget(
        iconCard: SvgPicture.asset(
          Paths.iconeRedefinirSenha,
          height: 4.5.h,
          width: 4.5.h,
          colorFilter: const ColorFilter.mode(
            AppColors.defaultColor,
            BlendMode.srcIn
          ),
        ),
        titleIconPath: "Redefinir Senha",
        onTap: () => Get.to(() => const ResetPasswordPage()),
      ),
    ].obs;
  }
}