import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/button_widget.dart';
import '../../../utils/sharedWidgets/dropdown_button_widget.dart';
import '../../../utils/sharedWidgets/gym_item_widget.dart';
import '../../../utils/sharedWidgets/picture_person_widget.dart';
import '../../../utils/sharedWidgets/snackbar_widget.dart';
import '../../../utils/sharedWidgets/text_field_description_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/sharedWidgets/text_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/user_profile_controller.dart';

class UserProfileTabsWidget{
  static List<Widget> getList(UserProfileController controller) {
    return [
      Padding(
        padding: EdgeInsets.only(left: .5.w, top: 2.h, right: .5.w),
        child: Form(
          key: controller.formKeyPersonalInformation,
          child: Obx(
            () => ListView(
              children: [
                TextFieldWidget(
                  controller: controller.nameTextController,
                  hintText: "Nome",
                  justRead: controller.profileIsDisabled.value,
                  textCapitalization: TextCapitalization.words,
                  height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                  width: double.infinity,
                  keyboardType: TextInputType.name,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.next,
                  hasError: controller.nameInputHasError.value,
                  validator: (String? value) {
                    String? validation = TextFieldValidators.standardValidation(value, "Informe o seu Nome");
                    if(validation != null && validation != ""){
                      controller.nameInputHasError.value = true;
                    }
                    else{
                      controller.nameInputHasError.value = false;
                    }
                    return validation;
                  },
                  onEditingComplete: (){
                    controller.birthDateFocusNode.requestFocus();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.5.h),
                  child: InkWell(
                    onTap: () {
                      if(!controller.profileIsDisabled.value) {
                        SnackbarWidget(
                          warningText: "Aviso",
                          informationText: "Não é possível editar esse campo",
                          backgrondColor: AppColors.defaultColor,
                        );
                      }
                    },
                    child: TextFieldWidget(
                      controller: controller.loginTextController,
                      hintText: "Login",
                      justRead: true,
                      height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.5.h),
                  child: TextFieldWidget(
                    focusNode: controller.birthDateFocusNode,
                    controller: controller.birthDateTextController,
                    justRead: controller.profileIsDisabled.value,
                    hintText: "Data de Nascimento",
                    height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                    width: double.infinity,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maskTextInputFormatter: [MasksForTextFields.birthDateMask],
                    hasError: controller.birthdayInputHasError.value,
                    validator: (String? value) {
                      String? validation = TextFieldValidators.birthDayValidation(value, "de Nascimento");
                      if(validation != null && validation != ""){
                        controller.birthdayInputHasError.value = true;
                      }
                      else{
                        controller.birthdayInputHasError.value = false;
                      }
                      return validation;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5),
                  child: DropdownButtonWidget(
                    itemSelected: controller.genderSelected.value.isEmpty ? null : controller.genderSelected.value,
                    hintText: "Sexo",
                    justRead: controller.profileIsDisabled.value,
                    height: PlatformType.isTablet(Get.context!) ? 5.h : 6.5.h,
                    width: 90.w,
                    rxListItems: controller.genderList,
                    onChanged: (selectedState) {
                      controller.genderSelected.value = selectedState ?? "";
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: .5.w, top: 2.h, right: .5.w),
        child: Form(
          key: controller.formKeyContactInformation,
          child: Obx(
            () => ListView(
              children: [
                TextFieldWidget(
                  focusNode: controller.cellPhoneFocusNode,
                  controller: controller.cellPhoneTextController,
                  hintText: "Celular",
                  justRead: controller.profileIsDisabled.value,
                  textInputAction: TextInputAction.next,
                  height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                  width: double.infinity,
                  keyboardType: TextInputType.phone,
                  maskTextInputFormatter: [controller.maskCellPhoneFormatter],
                  onChanged: (cellPhoneTyped) => controller.phoneTextFieldEdited(cellPhoneTyped),
                  hasError: controller.cellPhoneInputHasError.value,
                  validator: (String? value) {
                    String? validation = TextFieldValidators.cellPhoneValidation(value);
                    if(validation != null && validation != ""){
                      controller.cellPhoneInputHasError.value = true;
                    }
                    else{
                      controller.cellPhoneInputHasError.value = false;
                    }
                    return validation;
                  },
                  onEditingComplete: (){
                    controller.emailFocusNode.requestFocus();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.5.h),
                  child: TextFieldWidget(
                    focusNode: controller.emailFocusNode,
                    controller: controller.emailTextController,
                    hintText: "E-mail",
                    justRead: controller.profileIsDisabled.value,
                    textInputAction: TextInputAction.next,
                    height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                    width: double.infinity,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    hasError: controller.emailInputHasError.value,
                    validator: (String? value) {
                      String? validation = TextFieldValidators.emailValidation(value);
                      if(validation != null && validation != ""){
                        controller.emailInputHasError.value = true;
                      }
                      else{
                        controller.emailInputHasError.value = false;
                      }
                      return validation;
                    },
                    onEditingComplete: (){
                      controller.confirmEmailFocusNode.requestFocus();
                    },
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !controller.profileIsDisabled.value,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: TextFieldWidget(
                        focusNode: controller.confirmEmailFocusNode,
                        controller: controller.confirmEmailTextController,
                        hintText: "Confirme o E-mail",
                        justRead: controller.profileIsDisabled.value,
                        height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        hasError: controller.confirmEmailInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.emailConfirmationValidation(
                            controller.emailTextController.text,
                            value,
                          );

                          if(validation != null && validation != ""){
                            controller.confirmEmailInputHasError.value = true;
                          }
                          else{
                            controller.confirmEmailInputHasError.value = false;
                          }
                          return validation;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 40.h,
        margin: EdgeInsets.only(left: .5.w, top: 2.h, right: .5.w),
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: controller.gymNameTextController,
                      hintText: "Nome da Academia",
                      justRead: controller.profileIsDisabled.value,
                      textInputAction: TextInputAction.done,
                      height: PlatformType.isTablet(Get.context!) ? 7.h : 9.h,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  ButtonWidget(
                    hintText: "OK",
                    widthButton: 20.w,
                    fontWeight: FontWeight.bold,
                    borderColor: controller.profileIsDisabled.value ? AppColors.grayBackgroundPictureColor : AppColors.defaultColor,
                    backgroundColor: controller.profileIsDisabled.value ? AppColors.grayBackgroundPictureColor : AppColors.defaultColor,
                    onPressed: () => controller.addGyms(),
                  ),
                ],
              ),
              TextWidget(
                "Academias",
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                textColor: AppColors.blackColor,
              ),
              SizedBox(
                height: 1.h,
              ),
              Visibility(
                visible: controller.gymsList.isNotEmpty,
                replacement: SizedBox(
                  height: 28.h,
                  child: Center(
                    child: TextWidget(
                      "Nenhuma academia adicionada",
                      textColor: AppColors.grayTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.gymsList.length,
                  itemBuilder: (context, index) => GymItemList(
                    gymName: controller.gymsList[index].name,
                    onDelete: controller.profileIsDisabled.value ? null : () => controller.deleteGyms(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Obx(
        () => Container(
          height: 40.h,
          padding: EdgeInsets.only(left: .5.w, top: 2.h, right: .5.w),
          child: Column(
            children: [
              ButtonWidget(
                hintText: "Adicionar imagem",
                fontWeight: FontWeight.bold,
                widthButton: 75.w,
                borderColor: controller.profileIsDisabled.value ? AppColors.grayBackgroundPictureColor : AppColors.defaultColor,
                backgroundColor: controller.profileIsDisabled.value ? AppColors.grayBackgroundPictureColor : AppColors.defaultColor,
                onPressed: () async => await controller.addNewPicture(),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Visibility(
                  visible: controller.images.isNotEmpty,
                  replacement: Center(
                    child: TextWidget(
                      "Nenhuma imagem adicionada",
                      textColor: AppColors.grayTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  child: ListView.builder(
                    controller: controller.imagesListController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: controller.profileIsDisabled.value ? null : () => ViewPicture.openPicture(
                          controller.images[index].base64,
                        ),
                        child: LazyLoadingList(
                          initialSizeOfItems: 2,
                          index: index,
                          loadMore: () {},
                          hasMore: true,
                          child: PicturePersonWidget(
                            path: controller.images[index].base64,
                            onDelete: () async => await controller.removePicture(index),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: .5.w, top: 2.h, right: .5.w),
        child: Obx(
          () => TextFieldDescriptionWidget(
            controller: controller.aboutMeTextController,
            hintText: "Fale sobre você",
            justRead: controller.profileIsDisabled.value,
            textCapitalization: TextCapitalization.sentences,
            height: 40.h,
            width: double.infinity,
            maxLines: 50,
            keyboardType: TextInputType.text,
            enableSuggestions: true,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
    ];
  }
}