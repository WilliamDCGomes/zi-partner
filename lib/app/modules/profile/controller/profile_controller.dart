import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/stylePages/app_colors.dart';
import 'package:zi_partner/base/services/user_service.dart';
import '../../../../base/services/interfaces/iuser_service.dart';
import '../../../utils/helpers/get_profile_picture_controller.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/popups/logout_popup.dart';
import '../../settingsApp/page/settings_app_page.dart';
import '../../userProfile/page/user_profile_page.dart';
import '../widget/profile_card_widget.dart';

class ProfileController extends GetxController {
  late RxBool hasPicture;
  late RxBool loadingPicture;
  late RxString profileImagePath;
  late List<ProfileCardWidget> cardProfileTabList;
  late IUserService _userService;

  ProfileController() {
    _initializeVariables();
  }

  @override
  void onInit() async {
    await refreshProfilePicture();
    super.onInit();
  }

  _initializeVariables() {
    hasPicture = false.obs;
    loadingPicture = true.obs;
    profileImagePath = "".obs;
    cardProfileTabList = [
      ProfileCardWidget(
        iconCard: Image.asset(
          Paths.iconeConfiguracaoMenu,
          height: 4.5.h,
          width: 4.5.h,
          color: AppColors.defaultColor,
        ),
        titleIconPath: "Configurações",
        onTap: () => Get.to(() => const SettingsAppPage()),
      ),
      ProfileCardWidget(
        iconCard: SvgPicture.asset(
          Paths.iconeSair,
          height: 4.5.h,
          width: 4.5.h,
          colorFilter: const ColorFilter.mode(
            AppColors.defaultColor,
            BlendMode.srcIn
          ),
        ),
        titleIconPath: "Sair",
        onTap: () {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return const LogoutPopup();
            },
          );
        },
      ),
    ];
    _userService = UserService();
  }

  refreshProfilePicture() async {
    await Future.delayed(const Duration(seconds: 2));
    await GetProfilePictureController.loadProfilePicture(
      loadingPicture,
      hasPicture,
      profileImagePath,
      _userService,
    );
  }

  openProfile() async {
    try {
      var result = await Get.to(() => const UserProfilePage());

      if(result != null && profileImagePath.value != result) {
        profileImagePath.value = result;
        hasPicture.value = profileImagePath.value.isNotEmpty;
        update(["profile-picture"]);
      }
      update(["name-of-user"]);
    }
    catch(_) {}
  }
}
