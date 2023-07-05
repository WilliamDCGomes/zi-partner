import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/helpers/format_numbers.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_button_widget.dart';
import '../../../base/models/person/person.dart';
import '../../modules/findPeople/controller/find_people_controller.dart';
import '../helpers/paths.dart';
import '../helpers/view_picture.dart';
import 'text_widget.dart';
import '../stylePages/app_colors.dart';

class CardPersonWidget extends StatefulWidget {
  final bool lastPerson;
  final bool detail;
  final Person person;
  final Function(bool, String)? action;
  late final FindPeopleController findPeopleController;

  CardPersonWidget({
    Key? key,
    required this.person,
    this.detail = false,
    this.lastPerson = false,
    this.action
  }) : super(key: key) {
    findPeopleController = Get.find(tag: "find-people-controller");
  }

  @override
  State<CardPersonWidget> createState() => _CardPersonWidgetState();
}

class _CardPersonWidgetState extends State<CardPersonWidget> {
  late RxInt activeStep;

  @override
  void initState() {
    activeStep = 0.obs;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      activeStep.value = 0;
    });
    super.initState();
  }

  Widget _getImages() {
    return widget.person.picture != null &&
        widget.person.picture!.isNotEmpty
        ? CarouselSlider.builder(
      carouselController: widget.person.carouselController,
      itemCount: widget.person.picture!.length,
      options: CarouselOptions(
          viewportFraction: 1,
          height: double.infinity,
          enableInfiniteScroll: false,
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: (itemIndex, reason) {
            activeStep.value = itemIndex;
          }),
      itemBuilder: (context, index, pageViewIndex) {
        return LazyLoadingList(
          initialSizeOfItems: 2,
          index: index,
          loadMore: () {},
          hasMore: true,
          child: InkWell(
            onTap: () {
              if(!widget.detail) {
                widget.findPeopleController.openPersonDetail(widget.person);
              }
              else{
                /// TODO - Fazer ele trazer as imagens do banco (Remover fromAsset)
                ViewPicture.openPicture(
                  widget.person.picture![index].base64,
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.circular(2.h),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(
                    base64Decode(widget.person.picture![index].base64),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ) : InkWell(
      onTap: () => widget.findPeopleController.openPersonDetail(widget.person),
      child: Center(
        child: TextWidget(
          "Sem fotos",
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          textColor: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget getDistanceLayout() {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Visibility(
        visible: widget.person.distance != null,
        replacement: TextWidget(
          "Distância: Desconhecida",
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
          textColor: AppColors.whiteColor,
        ),
        child: TextWidget(
          "Distância: ${FormatNumbers.numbersToStringOneDigit(widget.person.distance)} km",
          fontSize: 17.sp,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
          textColor: AppColors.whiteColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.lastPerson,
      replacement: Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
        child: Center(
          child: TextWidget(
            "Não há mais pessoas próximas a você!",
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            textColor: AppColors.grayTextColor,
            maxLines: 2,
          ),
        ),
      ),
      child: Material(
        child: Container(
          height: widget.detail ? 70.h : 60.h,
          width: widget.detail ? double.infinity : 80.w,
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.h),
            color: AppColors.defaultColorWithOpacity,
          ),
          child: Stack(
            children: [
              !widget.detail ? Hero(
                tag: "image-profile-${widget.person.userName}",
                child: Material(
                  color: AppColors.transparentColor,
                  child: _getImages(),
                ),
              ) : _getImages(),
              if (widget.person.picture != null &&
                  widget.person.picture!.isNotEmpty)
                Obx(
                  () => Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: .5.h),
                      child: DotStepper(
                        dotCount: widget.person.picture!.length > 1
                            ? widget.person.picture!.length
                            : 2,
                        spacing: 5.w,
                        dotRadius: 1.5.h,
                        shape: Shape.pipe,
                        indicator: Indicator.jump,
                        activeStep: activeStep.value,
                        fixedDotDecoration: FixedDotDecoration(
                          color: AppColors.grayStepColorWithOpacity,
                        ),
                        indicatorDecoration: const IndicatorDecoration(
                          color: AppColors.whiteColor,
                        ),
                        onDotTapped: (tappedDotIndex) {
                          setState(() {
                            activeStep.value = tappedDotIndex;
                            widget.person.carouselController
                                .jumpToPage(tappedDotIndex);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              if(!widget.detail)
                Padding(
                  padding: EdgeInsets.only(left: 4.w, bottom: 2.h, right: 4.w),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        color: AppColors.black40TransparentColor,
                      ),
                      padding: EdgeInsets.all(1.5.h),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Hero(
                            tag: "information-profile-${widget.person.userName}",
                            child: Material(
                              color: AppColors.transparentColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    widget.person.name,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                    textColor: AppColors.whiteColor,
                                  ),
                                  if (widget.person.gyms != null && widget.person.gyms!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: .5.h),
                                      child: TextWidget(
                                        widget.person.gyms!.first.name,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.start,
                                        textColor: AppColors.whiteColor,
                                      ),
                                    ),
                                  getDistanceLayout(),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Hero(
                                tag: "confirm-or-deny-profile-${widget.person.userName}",
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButtonWidget(
                                      onTap: widget.action != null ? () => widget.action!(false, widget.person.userName) : null,
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
                                      onTap: widget.action != null ? () => widget.action!(true, widget.person.userName) : null,
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
                        ],
                      ),
                    ),
                  ),
                ),
              if (widget.person.picture != null &&
                  widget.person.picture!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => widget.person.carouselController.previousPage(),
                      child: SizedBox(
                        height: double.infinity,
                        width: 20.w,
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.whiteColor,
                            size: 4.h,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => widget.person.carouselController.nextPage(),
                      child: SizedBox(
                        height: double.infinity,
                        width: 20.w,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.whiteColor,
                            size: 4.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Visibility(
                visible: !widget.detail,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.5.h, right: 2.w),
                    child: InkWell(
                      onTap: () => widget.findPeopleController.openPersonDetail(widget.person),
                      child: Container(
                        padding: EdgeInsets.all(.5.h),
                        decoration: BoxDecoration(
                            color: AppColors.black40TransparentColor,
                            borderRadius: BorderRadius.circular(1.h)),
                        child: Icon(
                          Icons.info_outline,
                          color: AppColors.whiteColor,
                          size: 4.h,
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
    );
  }
}
