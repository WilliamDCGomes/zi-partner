import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/helpers/date_format_to_brazil.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/user_picture_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../messages/page/messages_page.dart';
import '../controller/matchs_controller.dart';

class MatchCardIconWidget extends StatelessWidget {
  final Person person;
  late final MatchsController matchsController;

  MatchCardIconWidget({
    Key? key,
    required this.person,
  }) : super(key: key) {
    matchsController = Get.find(tag: 'matchs-controller');
  }

  _refreshLastMessage() async {
    var result = await Get.to(() => MessagesPage(
      recipientPerson: person,
    ));

    if(result != null) {
      try {
        matchsController.refreshLastMessage(result);
      }
      catch(_){}
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _refreshLastMessage(),
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextWidget(
                            person.name,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.blackColor,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: TextWidget(
                            DateFormatToBrazil.getMessageDateOrHourFormated(person.lastMessage?.inclusion),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.blackTransparentColor,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    TextWidget(
                      person.lastMessage != null ? person.lastMessage!.message : "",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.blackTransparentColor,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
