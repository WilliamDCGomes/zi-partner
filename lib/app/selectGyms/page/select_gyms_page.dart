import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../base/models/gym/gym.dart';
import '../../modules/registerUser/widgets/header_register_stepper_widget.dart';
import '../../utils/helpers/platform_type.dart';
import '../../utils/sharedWidgets/button_widget.dart';
import '../../utils/sharedWidgets/text_field_widget.dart';
import '../../utils/sharedWidgets/title_with_back_button_widget.dart';
import '../../utils/stylePages/app_colors.dart';
import '../controller/select_gyms_controller.dart';
import '../widget/gym_widget.dart';

class SelectGymsPage extends StatefulWidget {
  final List<Gym> selectedGyms;

  const SelectGymsPage({
    Key? key,
    required this.selectedGyms,
  }) : super(key: key);

  @override
  State<SelectGymsPage> createState() => _SelectGymsPageState();
}

class _SelectGymsPageState extends State<SelectGymsPage> {
  late SelectGymsController controller;

  @override
  void initState() {
    controller = Get.put(
      SelectGymsController(widget.selectedGyms),
      tag: "gym-controller",
    );
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: GetBuilder(
                            init: controller,
                            id: "gyms-list",
                            builder: (_) => ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: const HeaderRegisterStepperWidget(
                                    firstText: "PASSO 4 DE 6",
                                    secondText: "Academias Frequentadas",
                                    thirdText: "Selecione uma academia ou adicione uma nova.",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.w, top: 2.h, right: 4.w),
                                  child: TextFieldWidget(
                                    controller: controller.gymsName,
                                    hintText: "Digite o nome da academia",
                                    height: PlatformType.isTablet(context) ? 7.h : 9.h,
                                    width: double.infinity,
                                    keyboardType: TextInputType.name,
                                    enableSuggestions: true,
                                    onChanged: (_) => controller.filterGymsByName(),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(left: 4.w, bottom: 5.h, right: 4.w),
                                  itemCount: controller.gyms.length,
                                  itemBuilder: (context, index) => GymWidget(
                                    gym: controller.gyms[index],
                                    onTap: () async {
                                      setState(() {
                                        controller.selectGym(index);
                                      });
                                    },
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
