import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/modules/findPeople/controller/find_people_controller.dart';
import 'package:zi_partner/app/utils/sharedWidgets/card_person_widget.dart';
import 'package:zi_partner/app/utils/stylePages/app_colors.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/text_widget.dart';

class FindPeoplePage extends StatefulWidget {
  const FindPeoplePage({Key? key}) : super(key: key);

  @override
  State<FindPeoplePage> createState() => _FindPeoplePageState();
}

class _FindPeoplePageState extends State<FindPeoplePage> {
  late final FindPeopleController controller;

  @override
  void initState() {
    controller = Get.put(FindPeopleController(), tag: "find-people-controller");
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
                        "Encontre pessoas\npara treinar!",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.defaultColor,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: .5.h, bottom: 2.h),
                    child: InkWell(
                      onTap: () => controller.getNextFivePeople(ignoreLimitation: true),
                      child: Padding(
                        padding: EdgeInsets.only(left: .5.h, top: .5.h, bottom: .5.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(
                              "Atualizar lista",
                              textColor: AppColors.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(
                              Icons.refresh,
                              color: AppColors.defaultColor,
                              size: 3.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => Visibility(
                      visible: controller.peopleList.isNotEmpty,
                      replacement: Center(
                        child: TextWidget(
                          "Sem pessoas próximas a você!",
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          textColor: AppColors.grayTextColor,
                          maxLines: 2,
                        ),
                      ),
                      child: Center(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          shrinkWrap: true,
                          itemCount: controller.peopleList.length,
                          itemBuilder: (context, index) => CardPersonWidget(
                            person: controller.peopleList[index],
                            action: (reaction, userName) => controller.reactPerson(reaction, userName),
                            lastPerson: controller.peopleList[index].userName.isEmpty,
                          ),
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
