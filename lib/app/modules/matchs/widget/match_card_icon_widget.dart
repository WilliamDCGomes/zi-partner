import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/user_picture_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../messages/page/messages_page.dart';

class MatchCardIconWidget extends StatelessWidget {
  final Person person;

  const MatchCardIconWidget({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => MessagesPage(
        recipientPerson: person,
      )),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: 2.h),
        color: AppColors.whiteColorWithVeryLowOpacity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.h),
          child: Row(
            children: [
              UserPictureWidget(
                person: person,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    person.name,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.blackColor,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextWidget(
                    person.lastMessage,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.blackColor,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
