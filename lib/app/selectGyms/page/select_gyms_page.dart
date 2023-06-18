import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../modules/registerUser/widgets/header_register_stepper_widget.dart';
import '../../utils/sharedWidgets/button_widget.dart';
import '../../utils/sharedWidgets/checkbox_list_tile_widget.dart';
import '../../utils/sharedWidgets/text_button_widget.dart';
import '../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../utils/stylePages/app_colors.dart';
import '../controller/select_gyms_controller.dart';
import '../widget/gym_widget.dart';

class SelectGymsPage extends StatefulWidget {
  const SelectGymsPage({Key? key}) : super(key: key);

  @override
  State<SelectGymsPage> createState() => _SelectGymsPageState();
}

class _SelectGymsPageState extends State<SelectGymsPage> {
  late SelectGymsController controller;

  @override
  void initState() {
    controller = Get.put(SelectGymsController(), tag: "gym-controller");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Material(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: AppColors.backgroundFirstScreenColor,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h,),
                  child: Scaffold(
                    backgroundColor: AppColors.transparentColor,
                    body: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.h,),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 35.w,
                              child: const TitleWithBackButtonWidget(
                                title: "Academias",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const HeaderRegisterStepperWidget(
                                  firstText: "PASSO 4 DE 6",
                                  secondText: "Academias Frequentadas",
                                  thirdText: "Selecione uma academia ou adicione uma nova.",
                                ),
                                Obx(
                                  () => TextButtonWidget(
                                    onTap: () => controller.selectAllCategories(),
                                    width: 45.w,
                                    componentPadding: EdgeInsets.only(left: 4.w),
                                    widgetCustom: Align(
                                      alignment: Alignment.centerLeft,
                                      child: CheckboxListTileWidget(
                                        radioText: "Selecionar Todos",
                                        size: 2.h,
                                        checked: controller.allGymsSelected.value,
                                        justRead: true,
                                        onChanged: (){},
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GetBuilder(
                                    init: controller,
                                    id: "gyms-list",
                                    builder: (_) => ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(left: 4.w, bottom: 5.h, right: 4.w),
                                      itemCount: controller.gyms.length,
                                      itemBuilder: (context, index) => GymWidget(
                                        gym: controller.gyms[index],
                                        onTap: () async {
                                          setState(() {
                                            controller.gyms[index].selected = !controller.gyms[index].selected;
                                            if(controller.allGymsSelected.value && !controller.gyms[index].selected){
                                              controller.allGymsSelected.value = controller.gyms[index].selected;
                                            }
                                            else {
                                              controller.allGymsSelected.value = (!controller.allGymsSelected.value && controller.gyms[index].selected && controller.gyms.length == 1) ||
                                                  (!controller.allGymsSelected.value && controller.gyms.where((category) => category.selected).length == controller.gyms.length);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h,),
                            child: ButtonWidget(
                              hintText: "SALVAR ACADEMIAS",
                              fontWeight: FontWeight.bold,
                              widthButton: double.infinity,
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                controller.saveGyms();
                              },
                            ),
                          ),
                        ),
                      ],
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
