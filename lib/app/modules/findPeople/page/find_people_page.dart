import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/modules/findPeople/controller/find_people_controller.dart';
import 'package:zi_partner/app/utils/sharedWidgets/card_person_widget.dart';
import 'package:zi_partner/app/utils/stylePages/app_colors.dart';
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
    controller = Get.put(FindPeopleController());
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
                SizedBox(
                  height: 1.h,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.peopleList.length,
                    itemBuilder: (context, index) => CardPersonWidget(
                      person: controller.peopleList[index],
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
