import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/modules/personDetail/page/person_detail_page.dart';
import 'package:zi_partner/app/utils/helpers/date_format_to_brazil.dart';
import 'package:zi_partner/app/utils/stylePages/app_colors.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/user_picture_widget.dart';
import '../controller/messages_controller.dart';

class MessagesPage extends StatefulWidget {
  final Person recipientPerson;

  const MessagesPage({
    Key? key,
    required this.recipientPerson,
  }) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final MessagesController controller;

  @override
  void initState() {
    controller = Get.put(MessagesController(widget.recipientPerson));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: WillPopScope(
          onWillPop: () async {
            controller.closeMessageScreen();
            return false;
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w),
                child: Scaffold(
                  backgroundColor: AppColors.transparentColor,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 8.h,
                        width: double.infinity,
                        padding: EdgeInsets.all(1.h),
                        margin: EdgeInsets.only(bottom: 2.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.defaultColor,
                              width: .1.h,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: InkWell(
                                onTap: () => controller.closeMessageScreen(),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.defaultColor,
                                  size: 3.h,
                                ),
                              ),
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () => Get.to(() => PersonDetailPage(
                                  person: controller.recipientPerson,
                                  disableMatchController: true,
                                )),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    UserPictureWidget(
                                      person: controller.recipientPerson,
                                      height: 5.h,
                                      width: 5.h,
                                    ),
                                    Flexible(
                                      child: TextWidget(
                                        controller.recipientPerson.name,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                        textColor: AppColors.defaultColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                            color: AppColors.backgroundColor,
                            child: Obx(
                              () => Column(
                                children: [
                                  Expanded(
                                    child: Visibility(
                                      visible: controller.messagesList.isNotEmpty,
                                      replacement: Center(
                                        child: TextWidget(
                                          "Mande algo para começar a conversa!",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp,
                                          textColor: AppColors.grayTextColor,
                                          maxLines: 2,
                                        ),
                                      ),
                                      child: GroupedListView<dynamic, String>(
                                        elements: controller.messagesList,
                                        shrinkWrap: true,
                                        controller: controller.scrollController,
                                        physics: const BouncingScrollPhysics(),
                                        groupBy: (item) => item.messageDate,
                                        groupSeparatorBuilder: (String groupByValue) => Padding(
                                          padding: EdgeInsets.only(bottom: .5.h),
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.all(1.h),
                                              margin: EdgeInsets.only(top: 1.h),
                                              decoration: BoxDecoration(
                                                color: AppColors.defaultColor,
                                                borderRadius: BorderRadius.circular(2.h),
                                              ),
                                              child: TextWidget(
                                                groupByValue,
                                                fontSize: 14.sp,
                                                textColor: AppColors.whiteColor,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                        itemComparator: (first, second) => first.inclusion.compareTo(second.inclusion),
                                        order: GroupedListOrder.ASC,
                                        itemBuilder: (context, dynamic message) {
                                          return Align(
                                            alignment: message.itsMine ? Alignment.centerRight : Alignment.centerLeft,
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 80.w, minWidth: 20.w),
                                              padding: EdgeInsets.all(1.h),
                                              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(1.h),
                                                color: message.itsMine ? AppColors.defaultColor : AppColors.defaultColorWithOpacity,
                                              ),
                                              child: LayoutBuilder(
                                                builder: (BuildContext context, BoxConstraints constraints) {
                                                  return ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      minWidth: constraints.minWidth,
                                                      maxWidth: constraints.maxWidth,
                                                      minHeight: constraints.minHeight,
                                                      maxHeight: constraints.maxHeight,
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Flexible(
                                                          child: TextWidget(
                                                            message.message,
                                                            fontSize: 17.sp,
                                                            fontWeight: FontWeight.w400,
                                                            textAlign: TextAlign.start,
                                                            maxLines: 20,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4.w),
                                                        TextWidget(
                                                          DateFormatToBrazil.hourFromDate(message.inclusion),
                                                          fontSize: 13.sp,
                                                          fontWeight: FontWeight.w400,
                                                          textAlign: TextAlign.end,
                                                          maxLines: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: controller.sendingMessage.value,
                                      child: Container(
                                        height: 5.h,
                                        width: 5.h,
                                        margin: EdgeInsets.symmetric(vertical: 1.h),
                                        child: const CircularProgressIndicator(
                                          color: AppColors.defaultColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              focusNode: controller.newMessageFocusNode,
                              controller: controller.newMessage,
                              hintText: "Mensagem",
                              height: 9.h,
                              width: double.infinity,
                              enableSuggestions: true,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          ButtonWidget(
                            widthButton: 15.w,
                            fontWeight: FontWeight.bold,
                            child: Icon(
                              Icons.send,
                              color: AppColors.whiteColor,
                              size: 3.h,
                            ),
                            onPressed: () => controller.sendMessage(),
                          ),
                        ],
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
    );
  }
}
