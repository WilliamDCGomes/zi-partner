import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/helpers/format_numbers.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/helpers/paths.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';

class CardPersonWidget extends StatelessWidget {
  final Person person;

  const CardPersonWidget({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 80.w,
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            2.h
        ),
        color: AppColors.grayTextColor,
      ),
      child: Stack(
        children: [
          person.picture != null && person.picture!.isNotEmpty ? CarouselSlider.builder(
            carouselController: person.carouselController,
            itemCount: person.picture!.length,
            options: CarouselOptions(
              viewportFraction: 1,
              height: double.infinity,
              enableInfiniteScroll: false,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      person.picture![itemIndex],
                    ),
                  ),
                ),
              );
            },
          ) : Center(
            child: TextWidget(
              "Sem fotos",
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.whiteColor,
            ),
          ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextWidget(
                      person.name,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      textColor: AppColors.whiteColor,
                    ),
                    if(person.gyms.isNotEmpty)
                      Row(
                        children: [
                          Flexible(
                            child: TextWidget(
                              person.gyms.first,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.start,
                              textColor: AppColors.whiteColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Icon(
                              Icons.star,
                              color: AppColors.whiteColor,
                              size: 2.h,
                            ),
                          ),
                          TextWidget(
                            "${FormatNumbers.numbersToStringOneDigit(person.distance)} km",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                            textColor: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    if(person.gyms.isEmpty)
                      TextWidget(
                        "${FormatNumbers.numbersToStringOneDigit(person.distance)} km",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                        textColor: AppColors.whiteColor,
                      ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
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
                            SizedBox(width: 5.w,),
                            Container(
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(person.picture != null && person.picture!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => person.carouselController.previousPage(),
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
                  onTap: () => person.carouselController.nextPage(),
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
        ],
      ),
    );
  }
}
