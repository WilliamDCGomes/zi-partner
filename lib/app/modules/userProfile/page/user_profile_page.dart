import 'dart:convert';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../enums/enums.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/profile_image_picture_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/user_profile_controller.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key,}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin{
  late UserProfileController controller;

  @override
  void initState() {
    controller = Get.put(UserProfileController());
    controller.tabController = TabController(
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.closeProfile();
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.backgroundFirstScreenColor,
              ),
            ),
            child: Stack(
              children: [
                Scaffold(
                  backgroundColor: AppColors.transparentColor,
                  body: Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              child: TitleWithBackButtonWidget(
                                title: "Perfil",
                              ),
                            ),
                            InkWell(
                              onTap: () => controller.deleteAccount(),
                              child: Icon(
                                Icons.delete,
                                color: AppColors.defaultColor,
                                size: 3.5.h,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: TextButtonWidget(
                            onTap: () {
                              if(controller.profileImagePath.value.isNotEmpty){
                                showImageViewer(
                                  context,
                                  Image.memory(
                                    base64Decode(controller.profileImagePath.value),
                                  ).image,
                                );
                              }
                            },
                            componentPadding: EdgeInsets.zero,
                            borderRadius: 10.h,
                            widgetCustom: GetBuilder(
                              id: "profile-picture",
                              init: controller,
                              builder: (_) => ProfileImagePictureWidget(
                                hasPicture: controller.hasPicture,
                                loadingPicture: controller.loadingPicture,
                                profileImagePath: controller.profileImagePath,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: GetBuilder(
                            id: "name-of-user",
                            init: controller,
                            builder: (_) => TextWidget(
                              "Olá, ${LoggedUser.nameAndLastName}!",
                              textColor: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: controller.tabsList,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.h, bottom: 1.h),
                          child: Obx(
                            () => ButtonWidget(
                              hintText: controller.buttonText.value,
                              fontWeight: FontWeight.bold,
                              widthButton: double.infinity,
                              borderColor: AppColors.defaultColor,
                              textColor: controller.profileIsDisabled.value ? AppColors.defaultColor : AppColors.whiteColor,
                              backgroundColor: controller.profileIsDisabled.value ? AppColors.whiteColor : AppColors.defaultColor,
                              onPressed: () => controller.editButtonPressed(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                    height: 9.h,
                    padding: EdgeInsets.fromLTRB(.5.h, 0, .5.h, .5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4.5.h),
                        topLeft: Radius.circular(4.5.h),
                      ),
                      color: AppColors.backgroundColor,
                    ),
                    child: Center(
                      child: TabBar(
                        controller: controller.tabController,
                        isScrollable: true,
                        indicatorColor: AppColors.defaultColor,
                        indicatorWeight: .3.h,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5.sp,
                        ),
                        labelColor: AppColors.defaultColor,
                        unselectedLabelColor: AppColors.grayTextColor,
                        tabs: [
                          Tab(
                            text: "Perfil",
                            icon: ImageIcon(
                              AssetImage(LoggedUser.gender == TypeGender.feminine ? Paths.profileWomanIcon : Paths.profileManIcon),
                              size: 4.h,
                            ),
                            height: 9.h,
                          ),
                          Tab(
                            text: "Contato",
                            icon: ImageIcon(
                              const AssetImage(Paths.contactIcon),
                              size: 4.h,
                            ),
                            height: 9.h,
                          ),
                          Tab(
                            text: "Academias",
                            icon: ImageIcon(
                              const AssetImage(Paths.gymPlaceIcon),
                              size: 4.h,
                            ),
                            height: 9.h,
                          ),
                          Tab(
                            text: "Fotos",
                            icon: ImageIcon(
                              const AssetImage(Paths.picturesIcon),
                              size: 4.h,
                            ),
                            height: 9.h,
                          ),
                          Tab(
                            text: "Sobre mim",
                            icon: ImageIcon(
                              const AssetImage(Paths.aboutMeIcon),
                              size: 4.h,
                            ),
                            height: 9.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                controller.loadingWithSuccessOrErrorWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
