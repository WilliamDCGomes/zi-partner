import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/modules/userProfile/page/user_profile_page.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/profile_image_picture_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key,}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController controller;

  @override
  void initState() {
    controller = Get.put(ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SizedBox(
          height: 80.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Image.asset(
                        Paths.logoZipartner,
                        height: 7.w,
                        width: 7.w,
                      ),
                    ),
                    TextWidget(
                      "Zi Partner",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.defaultColor,
                    ),
                    Expanded(
                      child: TextWidget(
                        "Perfil e\nConfigurações!",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.defaultColor,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: TextButtonWidget(
                    onTap: () => Get.to(() => const UserProfilePage()),
                    borderRadius: 2.h,
                    widgetCustom: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfileImagePictureWidget(
                          hasPicture: controller.hasPicture,
                          loadingPicture: controller.loadingPicture,
                          profileImagePath: controller.profileImagePath,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: .5.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 3.w),
                                child: TextWidget(
                                  LoggedUser.nameAndLastName + LoggedUser.userAge,
                                  textColor: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SvgPicture.asset(
                                Paths.iconeEditar,
                                height: 2.h,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.defaultColor,
                                  BlendMode.srcIn
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: ListView.builder(
                      itemCount: controller.cardProfileTabList.length,
                      itemBuilder: (context, index){
                        return Container(
                          key: Key("$index"),
                          child: controller.cardProfileTabList[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}