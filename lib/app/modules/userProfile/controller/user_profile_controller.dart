import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:zi_partner/app/modules/login/page/login_page.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../../../base/services/user_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/models/user/user.dart';
import '../../../enums/enums.dart';
import '../../../utils/helpers/get_profile_picture_controller.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/helpers/valid_cellphone_mask.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/loading_profile_picture_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../../utils/sharedWidgets/snackbar_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../mainMenu/page/main_menu_page.dart';
import '../widget/user_profile_tabs_widget.dart';

class UserProfileController extends GetxController {
  late bool imageChanged;
  late RxString nameInitials;
  late RxString userName;
  late RxString buttonText;
  late RxString genderSelected;
  late RxString profileImagePath;
  late RxBool hasPicture;
  late RxBool profileIsDisabled;
  late RxBool loadingPicture;
  late RxBool currentPasswordFieldEnabled;
  late RxBool newPasswordFieldEnabled;
  late RxBool confirmNewPasswordFieldEnabled;
  late RxBool nameInputHasError;
  late RxBool birthdayInputHasError;
  late RxBool cellPhoneInputHasError;
  late RxBool emailInputHasError;
  late RxBool confirmEmailInputHasError;
  late TabController tabController;
  late TextEditingController nameTextController;
  late TextEditingController loginTextController;
  late TextEditingController birthDateTextController;
  late TextEditingController cellPhoneTextController;
  late TextEditingController emailTextController;
  late TextEditingController confirmEmailTextController;
  late TextEditingController currentPasswordTextController;
  late TextEditingController newPasswordTextController;
  late TextEditingController confirmNewPasswordTextController;
  late TextEditingController gymNameTextController;
  late TextEditingController aboutMeTextController;
  late final GlobalKey<FormState> formKeyPersonalInformation;
  late final GlobalKey<FormState> formKeyContactInformation;
  late FocusNode birthDateFocusNode;
  late FocusNode cellPhoneFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode confirmEmailFocusNode;
  late FocusNode confirmPasswordFocusNode;
  late MaskTextInputFormatter maskCellPhoneFormatter;
  late List<Widget> tabsList;
  late RxList<String> genderList;
  late RxList<String> gymsList;
  late RxList<String> images;
  late XFile? profilePicture;
  late final ImagePicker _picker;
  late ScrollController imagesListController;
  late LoadingProfilePictureWidget loadingProfilePicture;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late User user;
  late IUserService _userService;

  UserProfileController(){
    _initializeVariables();
    _initializeLists();
    _getUserInformation();
  }

  @override
  void onInit() async {
    await GetProfilePictureController.loadProfilePicture(
      loadingPicture,
      hasPicture,
      profileImagePath,
      _userService,
    );
    super.onInit();
  }

  _initializeVariables(){
    imageChanged = false;
    nameInitials = LoggedUser.nameInitials.obs;
    userName = LoggedUser.nameAndLastName.obs;
    buttonText = "EDITAR".obs;
    genderSelected = "".obs;
    profileImagePath = "".obs;
    hasPicture = false.obs;
    loadingPicture = true.obs;
    profileIsDisabled = true.obs;
    currentPasswordFieldEnabled = true.obs;
    newPasswordFieldEnabled = true.obs;
    confirmNewPasswordFieldEnabled = true.obs;
    nameInputHasError = false.obs;
    birthdayInputHasError = false.obs;
    cellPhoneInputHasError = false.obs;
    emailInputHasError = false.obs;
    confirmEmailInputHasError = false.obs;
    genderList = <String>[].obs;
    gymsList = <String>[].obs;
    images = <String>[].obs;
    imagesListController = ScrollController();
    nameTextController = TextEditingController();
    loginTextController = TextEditingController();
    birthDateTextController = TextEditingController();
    cellPhoneTextController = TextEditingController();
    emailTextController = TextEditingController();
    confirmEmailTextController = TextEditingController();
    currentPasswordTextController = TextEditingController();
    newPasswordTextController = TextEditingController();
    confirmNewPasswordTextController = TextEditingController();
    gymNameTextController = TextEditingController();
    aboutMeTextController = TextEditingController();
    formKeyPersonalInformation = GlobalKey<FormState>();
    formKeyContactInformation = GlobalKey<FormState>();
    birthDateFocusNode = FocusNode();
    cellPhoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    confirmEmailFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    _picker = ImagePicker();
    maskCellPhoneFormatter = MasksForTextFields.phoneNumberAcceptExtraNumberMask;
    loadingProfilePicture = LoadingProfilePictureWidget();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    user = User.empty();
    _userService = UserService();
  }

  _initializeLists() {
    genderList.value = [
      "Masculino",
      "Feminino",
    ];

    tabsList = UserProfileTabsWidget.getList(this);
  }

  _getUserInformation(){
    nameTextController.text = LoggedUser.name;
    birthDateTextController.text = LoggedUser.birthdayDate;
    genderSelected.value = LoggedUser.gender == TypeGender.masculine ? genderList[0] : genderList[1];
    cellPhoneTextController.text = LoggedUser.cellPhone ?? "";
    emailTextController.text = LoggedUser.email;
    confirmEmailTextController.text = LoggedUser.email;
  }

  bool _validPersonalInformationAndAdvanceNextStep() {
    if(genderSelected.value.isEmpty){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Informe o seu sexo.",
          );
        },
      );
      return false;
    }
    return true;
  }

  phoneTextFieldEdited(String cellPhoneTyped){
    cellPhoneTextController.value = ValidCellPhoneMask.updateCellPhoneMask(
      cellPhoneTyped,
      maskCellPhoneFormatter,
    );
  }

  _setUserToUpdate(){
    user.name = nameTextController.text;
    //user.birthdayDate = birthDateTextController.text;
    //user.gender = genderSelected.value;
    user.cellphone = cellPhoneTextController.text;
    user.email = emailTextController.text;
    user.id = LoggedUser.id;
  }

  _updateLocaleUser(){
    nameTextController.text = user.name;
    //birthDateTextController.text = user.birthdate;
    //genderSelected.value = user.gender;
    cellPhoneTextController.text = user.cellphone ?? "";
    emailTextController.text = user.email ?? "";
    LoggedUser.id = user.id ?? "";
  }

  editButtonPressed() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if(profileIsDisabled.value){
      buttonText.value = "SALVAR";
      profileIsDisabled.value = false;
    }
    else{
      await loadingWithSuccessOrErrorWidget.startAnimation();

      await Future.delayed(const Duration(seconds: 1));

      if(!await InternetConnection.validInternet(
        "É necessário uma conexão com a internet para fazer o cadastro",
        loadingWithSuccessOrErrorWidget,
      )){
        return;
      }
      if(!_validProfile()){
        return;
      }
      if(gymsList.isEmpty){
        bool cancelMethod = false;
        await showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return ConfirmationPopup(
              title: "Aviso",
              subTitle: "Você não adicionou nenhuma academia na sua lista, tem certeza que deseja continuar?",
              firstButton: () => cancelMethod = true,
              secondButton: () {},
            );
          },
        );
        if(cancelMethod) return;
      }
      if(images.isEmpty){
        bool cancelMethod = false;
        await showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return ConfirmationPopup(
              title: "Aviso",
              subTitle: "Você não adicionou nenhuma imagem no seu perfil, tem certeza que deseja continuar?",
              firstButton: () => cancelMethod = true,
              secondButton: () {},
            );
          },
        );
        if(cancelMethod) return;
      }
      if(_validPersonalInformationAndAdvanceNextStep()){
        _setUserToUpdate();

        //if(await _saveUser()){
          await loadingWithSuccessOrErrorWidget.stopAnimation();
          await showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const InformationPopup(
                warningMessage: "Perfil atualizado com sucesso!",
              );
            },
          );
          _updateLocaleUser();
          buttonText.value = "EDITAR";
          profileIsDisabled.value = true;
          Get.offAll(() => const MainMenuPage());
        //}
      }
    }
  }

  bool _validProfile(){
    try{
      if(nameTextController.text == ""){
        nameInputHasError.value = true;
        tabController.index = 0;
        throw "Informe o seu Nome";
      }
      else{
        nameInputHasError.value = false;
      }

      String? birthDateValidation = TextFieldValidators.birthDayValidation(birthDateTextController.text, "de Nascimento");
      if(birthDateValidation != null && birthDateValidation != ""){
        birthdayInputHasError.value = true;
        tabController.index = 0;
        throw birthDateValidation;
      }
      else{
        birthdayInputHasError.value = false;
      }

      if(genderSelected.value.isEmpty){
        tabController.index = 0;
        throw "Informe o seu sexo.";
      }

      String? cellPhoneValidation = TextFieldValidators.cellPhoneValidation(cellPhoneTextController.text);
      if(cellPhoneValidation != null && cellPhoneValidation != ""){
        cellPhoneInputHasError.value = true;
        tabController.index = 2;
        throw cellPhoneValidation;
      }
      else{
        cellPhoneInputHasError.value = false;
      }

      String? emailValidation = TextFieldValidators.emailValidation(emailTextController.text);
      if(emailValidation != null && emailValidation != ""){
        emailInputHasError.value = true;
        tabController.index = 2;
        throw emailValidation;
      }
      else{
        emailInputHasError.value = false;
      }

      String? confirmEmailvalidation = TextFieldValidators.emailConfirmationValidation(
          emailTextController.text,
          confirmEmailTextController.text,
      );
      if(confirmEmailvalidation != null && confirmEmailvalidation != ""){
        confirmEmailInputHasError.value = true;
        tabController.index = 2;
        throw confirmEmailvalidation;
      }
      else{
        confirmEmailInputHasError.value = false;
      }
      return true;
    }
    catch(e){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InformationPopup(
            warningMessage: e.toString(),
          );
        },
      );
      return false;
    }
  }

  getProfileImage(ImageOrigin origin) async {
    try{
      profilePicture = await _picker.pickImage(
        source: origin == ImageOrigin.camera ?
          ImageSource.camera : ImageSource.gallery
      );
      if(profilePicture != null){
        if(await _saveProfilePicture()){
          imageChanged = true;
          SnackbarWidget(
            warningText: "Aviso",
            informationText: "Foto de perfil alterada com sucesso.",
            backgrondColor: AppColors.defaultColor,
          );
        }
      }
    }
    catch(e){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao atualizar a imagem de perfil.",
          );
        },
      );
    }
  }

  Future<bool> _saveProfilePicture() async {
    //return await _userService.sendUserProfilePicture(profilePicture!, _progressImage);
    return true;
  }

  confirmationDeleteProfilePicture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return ConfirmationPopup(
            title: "Aviso",
            subTitle: "Tem certeza que deseja apagar a foto de perfil",
            firstButton: () {},
            secondButton: () => _deleteProfilePicture(),
          );
        },
    );
  }

  _deleteProfilePicture() async {
    try{
      await loadingWithSuccessOrErrorWidget.startAnimation();
      //await _userService.deleteProfilePicture();
      await loadingWithSuccessOrErrorWidget.stopAnimation();
      imageChanged = true;
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Imagem de perfil apagada com sucesso!",
          );
        },
      );
      await GetProfilePictureController.loadProfilePicture(
        loadingPicture,
        hasPicture,
        profileImagePath,
        _userService,
      );
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao apagar a foto de perfil.\n Tente novamente mais tarde",
          );
        },
      );
    }
  }

  editProfilePicture() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Escolha o método desejado para adicionar a foto de perfil!",
          firstButtonText: "GALERIA",
          secondButtonText: "CÂMERA",
          firstButton: () async => await getProfileImage(ImageOrigin.gallery),
          secondButton: () async => await getProfileImage(ImageOrigin.camera),
        );
      },
    );
  }

  addGyms() {
    if(!profileIsDisabled.value) {
      if(gymNameTextController.text.isNotEmpty){
        FocusScope.of(Get.context!).requestFocus(FocusNode());
        gymsList.add(gymNameTextController.text);
        gymNameTextController.clear();
        gymsList.sort((a, b) => a.compareTo(b));
      }
      else{
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const InformationPopup(
              warningMessage: "Informe o nome da academia para adicionar ela á lista!",
            );
          },
        );
      }
    }
  }

  deleteGyms(int index) async {
    bool validation = false;

    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a academia da lista?",
          firstButton: () {},
          secondButton: () => validation = true,
        );
      },
    );

    if(validation) {
      gymsList.removeAt(index);
      gymsList.sort((a, b) => a.compareTo(b));
      SnackbarWidget(
        warningText: "Aviso",
        informationText: "Academia removido da lista com sucesso",
        backgrondColor: AppColors.defaultColor,
      );
    }
  }

  addNewPicture() async {
    if(!profileIsDisabled.value) {
      try {
        if(images.length < 6) {
          final image = await ViewPicture.addNewPicture();
          if (image != null && image.isNotEmpty) {
            int quantity = 0;

            for(var personImage in image){
              if(images.length < 6) {
                images.add(personImage);
                quantity++;
              }
              else {
                SnackbarWidget(
                  warningText: "Aviso",
                  informationText: quantity > 1 ? "Apenas $quantity imagens foram adicionadas à lista, o limite de fotos é 6." :
                  "Apenas 1 imagem foi adicionada à lista, o limite de fotos é 6.",
                  backgrondColor: AppColors.defaultColor,
                  maxLine: 2,
                );
                break;
              }
            }

            if(images.isNotEmpty && images.length > 1 && quantity == 1) {
              await imagesListController.position.moveTo(
                imagesListController.positions.last.maxScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
              await SchedulerBinding.instance.endOfFrame;
              await imagesListController.position.moveTo(
                imagesListController.positions.last.maxScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            }
          }
        }
        else{
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const InformationPopup(
                warningMessage: "Você pode adicionar no máximo 6 imagens ao seu perfil!",
              );
            },
          );
        }
      }
      catch (_) {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const InformationPopup(
              warningMessage: "Não foi possível adicionar a imagem",
            );
          },
        );
      }
    }
  }

  removePicture(int index) async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a imagem?",
          firstButton: () {},
          secondButton: () => images.removeAt(index),
        );
      },
    );
  }

  deleteAccount() async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Escolha uma das opções",
          subTitle: "Tem certeza que deseja apagar a sua conta?",
          firstButtonText: "CANCELAR",
          secondButtonText: "APAGAR",
          firstButton: () {},
          secondButton: () => _deleteAccount(),
        );
      },
    );
  }

  _deleteAccount() async {
    await loadingWithSuccessOrErrorWidget.startAnimation();
    await Future.delayed(const Duration(seconds: 2));
    await loadingWithSuccessOrErrorWidget.stopAnimation();
    await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const InformationPopup(
          warningMessage: "Conta deletada com sucesso!",
        );
      },
    );
    Get.offAll(() => const LoginPage());
  }
}