import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/enums/enums.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../utils/helpers/app_close_controller.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/main_menu_controller.dart';

class MainMenuPage extends StatefulWidget {
  final bool goToSecondTab;
  const MainMenuPage({
    Key? key,
    this.goToSecondTab = false,
  }) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> with SingleTickerProviderStateMixin{
  late MainMenuController controller;

  @override
  void initState() {
    controller = Get.put(MainMenuController(widget.goToSecondTab), tag: 'main-menu-controller');
    controller.tabController = TabController(
      length: 3,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return AppCloseController.verifyCloseScreen();
      },
      child: SafeArea(
        child: Material(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Scaffold(
                  body: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: AppColors.backgroundFirstScreenColor,
                      ),
                    ),
                    child: TabBarView(
                      controller: controller.tabController,
                      children: controller.tabMainMenuList,
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
                    child: TabBar(
                      controller: controller.tabController,
                      indicatorColor: AppColors.defaultColor,
                      indicatorWeight: .3.h,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      labelColor: AppColors.defaultColor,
                      unselectedLabelColor: AppColors.grayTextColor,
                      tabs: [
                        Tab(
                          icon: ImageIcon(
                            const AssetImage(Paths.tabHomeIcon),
                            size: 3.5.h,
                          ),
                          text: "Encontrar",
                          height: 9.h,
                        ),
                        Tab(
                          icon: ImageIcon(
                            const AssetImage(Paths.matchesTabIcon),
                            size: 3.5.h,
                          ),
                          text: "Matchs",
                          height: 9.h,
                        ),
                        Tab(
                          icon: ImageIcon(
                            AssetImage(LoggedUser.gender == TypeGender.feminine ? Paths.profileWomanIcon : Paths.profileManIcon),
                            size: 3.5.h,
                          ),
                          text: "Perfil",
                          height: 9.h,
                        ),
                      ],
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
