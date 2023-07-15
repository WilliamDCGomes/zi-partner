import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/helpers/format_numbers.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/card_person_widget.dart';
import '../../../utils/sharedWidgets/gym_item_widget.dart';
import '../../../utils/sharedWidgets/text_button_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/person_detail_controller.dart';

class PersonDetailPage extends StatelessWidget {
  final Person person;
  final bool disableMatchController;
  late final PersonDetailController controller;

  PersonDetailPage({
    Key? key,
    required this.person,
    this.disableMatchController = false,
  }) : super(key: key){
    controller = PersonDetailController(person);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SizedBox(
          height: 80.h,
          width: 100.w,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TitleWithBackButtonWidget(
                        title: "Detalhes do Perfil",
                      ),
                    ),
                    Hero(
                      tag: "image-profile-${controller.person.userName}",
                      child: CardPersonWidget(
                        person: controller.person,
                        detail: true,
                      ),
                    ),
                    Hero(
                      tag: "information-profile-${controller.person.userName}",
                      child: Material(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            TextWidget(
                              controller.person.name,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.blackColor,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                            Visibility(
                              visible: controller.person.distance != null && controller.person.distance!.toString().isNotEmpty,
                              child: Padding(
                                padding: EdgeInsets.only(top: 1.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.pin_drop_rounded,
                                      color: AppColors.blackColor,
                                      size: 2.h,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    TextWidget(
                                      "${FormatNumbers.numbersToStringOneDigit(controller.person.distance)} km",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppColors.blackColor,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: TextWidget(
                                "Sobre mim",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.blackColor,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1.h),
                              margin: EdgeInsets.only(top: .5.h, bottom: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.h),
                                border: Border.all(
                                  color: AppColors.blackColor,
                                  width: .1.h,
                                ),
                              ),
                              child: SizedBox(
                                height: 20.h,
                                child: Visibility(
                                  visible: controller.person.aboutMe.isNotEmpty,
                                  replacement: Center(
                                    child: TextWidget(
                                      "Não informado",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppColors.grayTextColor,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  child: ScrollbarTheme(
                                    data: ScrollbarThemeData(
                                      thumbColor: MaterialStateProperty.all<Color>(AppColors.defaultColor),
                                      trackColor: MaterialStateProperty.all<Color>(AppColors.grayTextColor),
                                      radius: Radius.circular(.5.h),
                                    ),
                                    child: Scrollbar(
                                      controller: controller.aboutMeScrollController,
                                      thumbVisibility: true,
                                      child: ListView(
                                        shrinkWrap: true,
                                        controller: controller.aboutMeScrollController,
                                        children: [
                                          TextWidget(
                                            controller.person.aboutMe,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            textColor: AppColors.blackColor,
                                            textAlign: TextAlign.start,
                                            maxLines: 60,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: TextWidget(
                                "Academias",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                                textColor: AppColors.blackColor,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: .5.h, bottom: 1.h),
                              child: controller.person.gyms != null && controller.person.gyms!.isNotEmpty ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.person.gyms!.length,
                                itemBuilder: (context, index) => GymItemList(
                                  gymName: controller.person.gyms![index].name,
                                ),
                              ) : Container(
                                height: 20.h,
                                padding: EdgeInsets.all(1.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.h),
                                  border: Border.all(
                                    color: AppColors.blackColor,
                                    width: .1.h,
                                  ),
                                ),
                                child: Center(
                                  child: TextWidget(
                                    "Nenhuma academia adicionada",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    textColor: AppColors.grayTextColor,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: disableMatchController,
                      replacement: SizedBox(
                        height: 10.h,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: ButtonWidget(
                          hintText: "DESFAZER MATCH",
                          fontWeight: FontWeight.bold,
                          backgroundColor: AppColors.whiteColor,
                          textColor: AppColors.defaultColor,
                          widthButton: 75.w,
                          onPressed: () => controller.deleteMatch(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !disableMatchController,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Hero(
                    tag: "confirm-or-deny-profile-${controller.person.userName}",
                    child: Card(
                      elevation: 3,
                      color: AppColors.whiteColorWithVeryLowOpacity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.h),
                      ),
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Padding(
                        padding: EdgeInsets.all(1.5.h),
                        child: SizedBox(
                          height: 6.h,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              TextButtonWidget(
                                onTap: () => controller.reactPerson(false, controller.person.userName),
                                componentPadding: EdgeInsets.zero,
                                widgetCustom: Container(
                                  height: 6.h,
                                  width: 6.h,
                                  padding: EdgeInsets.all(1.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.h),
                                    border: Border.all(
                                      color: AppColors.redColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Image.asset(
                                    Paths.denyPerson,
                                    color: AppColors.redColor,
                                    height: 2.h,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              TextButtonWidget(
                                onTap: () => controller.reactPerson(true, controller.person.userName),
                                componentPadding: EdgeInsets.zero,
                                widgetCustom: Container(
                                  height: 6.h,
                                  width: 6.h,
                                  padding: EdgeInsets.all(1.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.h),
                                    border: Border.all(
                                      color: AppColors.greenColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Image.asset(
                                    Paths.matchIcon,
                                    color: AppColors.greenColor,
                                    height: 2.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              controller.loadingWithSuccessOrErrorWidget,
            ],
          ),
        ),
      ),
    );
  }
}
