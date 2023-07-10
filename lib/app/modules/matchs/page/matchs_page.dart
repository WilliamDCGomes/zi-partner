import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/stylePages/app_colors.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../controller/matchs_controller.dart';
import '../widget/match_card_icon_widget.dart';

class MatchsPage extends StatefulWidget {
  const MatchsPage({Key? key}) : super(key: key);

  @override
  State<MatchsPage> createState() => _MatchsPageState();
}

class _MatchsPageState extends State<MatchsPage> {
  late final MatchsController controller;

  @override
  void initState() {
    controller = Get.put(MatchsController());
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
                        "Seus matchs\npara treinar!",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.defaultColor,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                  child: TextWidget(
                    "Matchs",
                    textColor: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => Visibility(
                      visible: controller.matchsList.isNotEmpty,
                      replacement: Center(
                        child: TextWidget(
                          "Você ainda não tem nenhum match, continue procurando.",
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          textColor: AppColors.grayTextColor,
                          maxLines: 2,
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.matchsList.length,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) => MatchCardIconWidget(
                          person: controller.matchsList[index],
                        ),
                      ),
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
