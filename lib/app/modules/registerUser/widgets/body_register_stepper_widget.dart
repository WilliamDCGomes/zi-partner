import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zi_partner/app/utils/sharedWidgets/button_widget.dart';
import 'package:zi_partner/app/utils/sharedWidgets/text_widget.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/platform_type.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/dropdown_button_widget.dart';
import '../../../utils/sharedWidgets/gym_item_widget.dart';
import '../../../utils/sharedWidgets/picture_person_widget.dart';
import '../../../utils/sharedWidgets/text_field_description_widget.dart';
import '../../../utils/sharedWidgets/text_field_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../controller/register_user_controller.dart';

class BodyRegisterStepperWidget extends StatefulWidget {
  final RegisterUserController controller;
  final int indexView;

  const BodyRegisterStepperWidget(
  { Key? key,
    required this.controller,
    required this.indexView,
  }) : super(key: key);

  @override
  State<BodyRegisterStepperWidget> createState() => _BodyRegisterStepperWidgetState();
}

class _BodyRegisterStepperWidgetState extends State<BodyRegisterStepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 5.h),
      child: Column(
        children: [
          // Entrys do primeiro stepper
          Visibility(
            visible: widget.indexView == 0,
            child: Form(
              key: widget.controller.formKeyPersonalInformation,
              child: Obx(
                () => Column(
                  children: [
                    TextFieldWidget(
                      controller: widget.controller.nameTextController,
                      hintText: "Nome",
                      textCapitalization: TextCapitalization.words,
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      keyboardType: TextInputType.name,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.next,
                      hasError: widget.controller.nameInputHasError.value,
                      validator: (String? value) {
                        String? validation = TextFieldValidators.standardValidation(value, "Informe o seu Nome");
                        if(validation != null && validation != ""){
                          widget.controller.nameInputHasError.value = true;
                        }
                        else{
                          widget.controller.nameInputHasError.value = false;
                        }
                        return validation;
                      },
                      onEditingComplete: (){
                        widget.controller.loginFocusNode.requestFocus();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: TextFieldWidget(
                        controller: widget.controller.userNameTextController,
                        focusNode: widget.controller.loginFocusNode,
                        hintText: "Login",
                        textCapitalization: TextCapitalization.words,
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.name,
                        enableSuggestions: true,
                        maskTextInputFormatter: [MasksForTextFields.loginMask],
                        textInputAction: TextInputAction.next,
                        hasError: widget.controller.loginInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.standardValidation(value, "Informe o seu Login");
                          if(validation != null && validation != ""){
                            widget.controller.loginInputHasError.value = true;
                          }
                          else{
                            widget.controller.loginInputHasError.value = false;
                          }
                          return validation;
                        },
                        onEditingComplete: (){
                          widget.controller.birthDateFocusNode.requestFocus();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: TextFieldWidget(
                        focusNode: widget.controller.birthDateFocusNode,
                        controller: widget.controller.birthDateTextController,
                        hintText: "Data de Nascimento",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maskTextInputFormatter: [MasksForTextFields.birthDateMask],
                        hasError: widget.controller.birthdayInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.birthDayValidation(value, "de Nascimento");
                          if(validation != null && validation != ""){
                            widget.controller.birthdayInputHasError.value = true;
                          }
                          else{
                            widget.controller.birthdayInputHasError.value = false;
                          }
                          return validation;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: DropdownButtonWidget(
                        itemSelected: widget.controller.genderSelected.value.isEmpty ? null : widget.controller.genderSelected.value,
                        hintText: "Sexo",
                        height: PlatformType.isTablet(context) ? 5.h : 6.5.h,
                        width: 90.w,
                        listItems: widget.controller.genderList,
                        onChanged: (selectedState) {
                          widget.controller.genderSelected.value = selectedState ?? "";
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Entrys do segundo stepper
          Visibility(
            visible: widget.indexView == 1,
            child: Form(
              key: widget.controller.formKeyPasswordInformation,
              child: Obx(
                () => Column(
                  children: [
                    TextFieldWidget(
                      controller: widget.controller.passwordTextController,
                      hintText: "Senha",
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      textInputAction: TextInputAction.next,
                      hasError: widget.controller.passwordInputHasError.value,
                      validator: (String? value) {
                        String? validation = TextFieldValidators.passwordValidation(value);
                        if(validation != null && validation != ""){
                          widget.controller.passwordInputHasError.value = true;
                        }
                        else{
                          widget.controller.passwordInputHasError.value = false;
                        }
                        return validation;
                      },
                      onEditingComplete: (){
                        widget.controller.confirmPasswordFocusNode.requestFocus();
                      },
                      isPassword: widget.controller.passwordFieldEnabled.value,
                      iconTextField: GestureDetector(
                        onTap: () {
                          widget.controller.passwordFieldEnabled.value =
                          !widget.controller.passwordFieldEnabled.value;
                        },
                        child: Icon(
                          widget.controller.passwordFieldEnabled.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.blackColor,
                          size: 2.5.h,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: TextFieldWidget(
                        focusNode: widget.controller.confirmPasswordFocusNode,
                        controller: widget.controller.confirmPasswordTextController,
                        hintText: "Confirme a Senha",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        hasError: widget.controller.confirmPasswordInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.confirmPasswordValidation(widget.controller.passwordTextController.text, value);
                          if(validation != null && validation != ""){
                            widget.controller.confirmPasswordInputHasError.value = true;
                          }
                          else{
                            widget.controller.confirmPasswordInputHasError.value = false;
                          }
                          return validation;
                        },
                        isPassword: widget.controller.confirmPasswordFieldEnabled.value,
                        iconTextField: GestureDetector(
                          onTap: () {
                            widget.controller.confirmPasswordFieldEnabled.value =
                            !widget.controller.confirmPasswordFieldEnabled.value;
                          },
                          child: Icon(
                            widget.controller.confirmPasswordFieldEnabled.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.blackColor,
                            size: 2.5.h,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Entrys do terceiro stepper
          Visibility(
            visible: widget.indexView == 2,
            child: Form(
              key: widget.controller.formKeyContactInformation,
              child: Obx(
                () => Column(
                  children: [
                    TextFieldWidget(
                      focusNode: widget.controller.cellPhoneFocusNode,
                      controller: widget.controller.cellPhoneTextController,
                      hintText: "Celular",
                      textInputAction: TextInputAction.next,
                      height: PlatformType.isTablet(context) ? 7.h : 9.h,
                      width: double.infinity,
                      keyboardType: TextInputType.phone,
                      maskTextInputFormatter: [widget.controller.maskCellPhoneFormatter],
                      onChanged: (cellPhoneTyped) => widget.controller.phoneTextFieldEdited(cellPhoneTyped),
                      hasError: widget.controller.cellPhoneInputHasError.value,
                      validator: (String? value) {
                        String? validation = TextFieldValidators.cellPhoneValidation(value);
                        if(validation != null && validation != ""){
                          widget.controller.cellPhoneInputHasError.value = true;
                        }
                        else{
                          widget.controller.cellPhoneInputHasError.value = false;
                        }
                        return validation;
                      },
                      onEditingComplete: (){
                        widget.controller.emailFocusNode.requestFocus();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: TextFieldWidget(
                        focusNode: widget.controller.emailFocusNode,
                        controller: widget.controller.emailTextController,
                        hintText: "E-mail",
                        textInputAction: TextInputAction.next,
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        hasError: widget.controller.emailInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.emailValidation(value);
                          if(validation != null && validation != ""){
                            widget.controller.emailInputHasError.value = true;
                          }
                          else{
                            widget.controller.emailInputHasError.value = false;
                          }
                          return validation;
                        },
                        onEditingComplete: (){
                          widget.controller.confirmEmailFocusNode.requestFocus();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.5.h),
                      child: TextFieldWidget(
                        focusNode: widget.controller.confirmEmailFocusNode,
                        controller: widget.controller.confirmEmailTextController,
                        hintText: "Confirme o E-mail",
                        height: PlatformType.isTablet(context) ? 7.h : 9.h,
                        width: double.infinity,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        hasError: widget.controller.confirmEmailInputHasError.value,
                        validator: (String? value) {
                          String? validation = TextFieldValidators.emailConfirmationValidation(widget.controller.emailTextController.text, value);
                          if(validation != null && validation != ""){
                            widget.controller.confirmEmailInputHasError.value = true;
                          }
                          else{
                            widget.controller.confirmEmailInputHasError.value = false;
                          }
                          return validation;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Entrys do quarto stepper
          Visibility(
            visible: widget.indexView == 3,
            child: SizedBox(
              height: 40.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ButtonWidget(
                      hintText: "Selecionar Academias",
                      fontWeight: FontWeight.bold,
                      widthButton: 75.w,
                      onPressed: () => widget.controller.addGyms(),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
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
                  Expanded(
                    child: Obx(
                      () => Visibility(
                        visible: widget.controller.gyms.isNotEmpty,
                        replacement: Center(
                          child: TextWidget(
                            "Nenhuma academia adicionada",
                            textColor: AppColors.grayTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.controller.gyms.length,
                          itemBuilder: (context, index) => GymItemList(
                            gymName: widget.controller.gyms[index].name,
                            onDelete: () => widget.controller.deleteGyms(index)
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Entrys do quinto stepper
          Visibility(
            visible: widget.indexView == 4,
            child: Obx(
              () => SizedBox(
                height: 40.h,
                child: Column(
                  children: [
                    ButtonWidget(
                      hintText: "Adicionar imagem",
                      fontWeight: FontWeight.bold,
                      widthButton: 75.w,
                      onPressed: () async => await widget.controller.addNewPicture(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Expanded(
                      child: Visibility(
                        visible: widget.controller.images.isNotEmpty,
                        replacement: Center(
                          child: TextWidget(
                            "Nenhuma imagem adicionada",
                            textColor: AppColors.grayTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        child: ListView.builder(
                          controller: widget.controller.imagesListController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.controller.images.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => ViewPicture.openPicture(widget.controller.images[index]),
                              child: LazyLoadingList(
                                initialSizeOfItems: 2,
                                index: index,
                                loadMore: () {},
                                hasMore: true,
                                child: PicturePersonWidget(
                                  path: widget.controller.images[index],
                                  onDelete: () async => await widget.controller.removePicture(index),
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
          ),

          // Entrys do sexto stepper
          Visibility(
            visible: widget.indexView == 5,
            child: TextFieldDescriptionWidget(
              controller: widget.controller.aboutMeTextController,
              hintText: "Fale sobre você",
              textCapitalization: TextCapitalization.sentences,
              height: 40.h,
              width: double.infinity,
              maxLines: 50,
              keyboardType: TextInputType.text,
              enableSuggestions: true,
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}