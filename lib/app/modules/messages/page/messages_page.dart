import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/modules/personDetail/page/person_detail_page.dart';
import 'package:zi_partner/app/utils/helpers/date_format_to_brazil.dart';
import 'package:zi_partner/app/utils/stylePages/app_colors.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/sharedWidgets/user_picture_widget.dart';
import 'messages_controller.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.scrollController.jumpTo(controller.scrollController.position.maxScrollExtent);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
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
                          onTap: () => Get.back(),
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
                        () => Visibility(
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            controller: controller.scrollController,
                            itemCount: controller.messagesList.length,
                            itemBuilder: (context, index) => Align(
                              alignment: controller.messagesList[index].itsMine ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(maxWidth: 80.w, minWidth: 20.w),
                                padding: EdgeInsets.all(1.h),
                                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.h),
                                  color: controller.messagesList[index].itsMine ? AppColors.defaultColor : AppColors.defaultColorWithOpacity,
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
                                              controller.messagesList[index].message,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start,
                                              maxLines: 20,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          TextWidget(
                                            DateFormatToBrazil.hourFromDate(controller.messagesList[index].inclusion),
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
                            ),
                          ),
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
      ),
    );
  }
}
