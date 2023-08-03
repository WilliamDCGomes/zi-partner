import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zi_partner/app/modules/login/page/login_page.dart';
import 'package:zi_partner/app/utils/helpers/date_format_to_brazil.dart';
import 'package:zi_partner/base/models/gym/gym.dart';
import 'package:zi_partner/base/services/gym_service.dart';
import 'package:zi_partner/base/services/picture_service.dart';
import 'package:zi_partner/base/services/user_gym_service.dart';
import '../../../../../../base/services/interfaces/iuser_service.dart';
import '../../../../../../base/services/user_service.dart';
import '../../../../base/models/loggedUser/logged_user.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/models/user/user.dart';
import '../../../../base/models/userGym/user_gym.dart';
import '../../../../base/models/userPictures/user_pictures.dart';
import '../../../../base/services/interfaces/igym_service.dart';
import '../../../../base/services/interfaces/ipicture_service.dart';
import '../../../../base/services/interfaces/iuser_gym_service.dart';
import '../../../enums/enums.dart';
import '../../../selectGyms/page/select_gyms_page.dart';
import '../../../utils/helpers/get_profile_picture_controller.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/save_user_informations.dart';
import '../../../utils/helpers/text_field_validators.dart';
import '../../../utils/helpers/valid_cellphone_mask.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/loading_profile_picture_widget.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../../utils/sharedWidgets/snackbar_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../widget/user_profile_tabs_widget.dart';

class UserProfileController extends GetxController {
  late bool imageChanged;
  late bool gymChanged;
  late bool profileChanged;
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
  late TextEditingController userNameTextController;
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
  late RxList<UserPictures> images;
  late RxList<Gym> gymsList;
  late XFile? profilePicture;
  late ScrollController imagesListController;
  late LoadingProfilePictureWidget loadingProfilePicture;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late User user;
  late SharedPreferences sharedPreferences;
  late IUserService _userService;
  late IGymService _gymService;
  late IUserGymService _userGymService;
  late IPictureService _pictureService;

  UserProfileController(){
    _initializeVariables();
    _initializeLists();
    _getUserInformation();
  }

  @override
  void onInit() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 200));
    await loadingWithSuccessOrErrorWidget.startAnimation();
    await GetProfilePictureController.loadProfilePicture(
      loadingPicture,
      hasPicture,
      profileImagePath,
      _userService,
    );
    await _getUserInformationAsync();
    await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
    super.onInit();
  }

  _initializeVariables(){
    imageChanged = false;
    gymChanged = false;
    profileChanged = false;
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
    images = <UserPictures>[].obs;
    genderList = <String>[].obs;
    gymsList = <Gym>[].obs;
    imagesListController = ScrollController();
    nameTextController = TextEditingController();
    userNameTextController = TextEditingController();
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
    maskCellPhoneFormatter = MasksForTextFields.phoneNumberAcceptExtraNumberMask;
    loadingProfilePicture = LoadingProfilePictureWidget();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    user = User.empty();
    _userService = UserService();
    _gymService = GymService();
    _userGymService = UserGymService();
    _pictureService = PictureService();
  }

  _initializeLists() {
    genderList.value = [
      "Masculino",
      "Feminino",
    ];

    tabsList = UserProfileTabsWidget.getList(this);
  }

  _getUserInformation(){
    nameTextController.text = LoggedUser.fullName;
    userNameTextController.text = LoggedUser.userName;
    birthDateTextController.text = LoggedUser.birthdayDate;
    genderSelected.value = LoggedUser.gender == TypeGender.masculine ? genderList[0] : genderList[1];
    cellPhoneTextController.text = LoggedUser.cellPhone ?? "";
    emailTextController.text = LoggedUser.email;
    confirmEmailTextController.text = LoggedUser.email;
    aboutMeTextController.text = LoggedUser.aboutMe;
  }

  _getUserInformationAsync () async {
    try {
      var user = await _userService.getUserInformation(userNameTextController.text);

      if(user == null) throw Exception();
      if(user.gyms != null) {
        for(var gym in user.gyms!) {
          gymsList.add(gym);
        }
      }
      if(user.picture != null) {
        for(var picture in user.picture!) {
          images.add(picture);
        }
      }
    }
    catch(_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao carregar o perfil!\nTente novamente mais tarde.",
          );
        },
      );
      closeProfile();
    }
  }

  phoneTextFieldEdited(String cellPhoneTyped){
    cellPhoneTextController.value = ValidCellPhoneMask.updateCellPhoneMask(
      cellPhoneTyped,
      maskCellPhoneFormatter,
    );
  }

  _setUserToUpdate() async {
    user.name = nameTextController.text;
    user.userName = userNameTextController.text;
    user.password = sharedPreferences.getString("password") ?? LoggedUser.password;
    user.birthdayDate = DateFormatToBrazil.formatDateFromTextField(birthDateTextController.text);
    switch (genderSelected.value) {
      case "Masculino":
        user.gender = TypeGender.masculine;
        break;
      case "Feminino":
        user.gender = TypeGender.feminine;
        break;
      case "Não Informado":
        user.gender = TypeGender.none;
        break;
    }
    user.cellphone = cellPhoneTextController.text;
    user.email = emailTextController.text;
    user.id = LoggedUser.id;
    user.aboutMe = aboutMeTextController.text;
    user.playerId = const Uuid().v4();

    /*var status = await OneSignal.shared.getDeviceState();
    user.playerId = status != null ? status.userId ?? "" : "";
    LoggedUser.playerId = user.playerId;*/
  }

  editButtonPressed() async {
    try {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      if(profileIsDisabled.value){
        buttonText.value = "SALVAR";
        profileIsDisabled.value = false;
      }
      else{
        if(await InternetConnection.validInternet(
          "É necessário uma conexão com a internet para fazer o cadastro",
          loadingWithSuccessOrErrorWidget,
        ) && _validProfile()) {
          if(gymsList.isEmpty) {
            tabController.index = 2;
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
            tabController.index = 3;
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
          if(aboutMeTextController.text.isEmpty){
            tabController.index = 4;
            bool cancelMethod = false;
            await showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return ConfirmationPopup(
                  title: "Aviso",
                  subTitle: "Você não disse nada sobre você, tem certeza que deseja finalizar?",
                  firstButton: () => cancelMethod = true,
                  secondButton: () {},
                );
              },
            );
            if(cancelMethod) return;
          }
          await loadingWithSuccessOrErrorWidget.startAnimation();

          await _setUserToUpdate();

          if(await _updateUser() && await _updateUserLocale()) {
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

            update(["name-of-user"]);
            buttonText.value = "EDITAR";
            profileChanged = true;
            profileIsDisabled.value = true;
          }
          else {
            throw Exception();
          }
        }
      }
    }
    catch(_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao atualizar o perfil!\nTente novamente mais tarde.",
          );
        },
      );
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
        tabController.index = 1;
        throw cellPhoneValidation;
      }
      else{
        cellPhoneInputHasError.value = false;
      }

      String? emailValidation = TextFieldValidators.emailValidation(emailTextController.text);
      if(emailValidation != null && emailValidation != ""){
        emailInputHasError.value = true;
        tabController.index = 1;
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
        tabController.index = 1;
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

  addGyms() async {
    if(!profileIsDisabled.value) {
      List<Gym> backupGyms = <Gym>[];
      for(var gym in gymsList) {
        backupGyms.add(gym);
      }

      await Get.to(() => SelectGymsPage(selectedGyms: gymsList));
      gymsList.sort((a, b) => a.name.compareTo(b.name));

      if(backupGyms.length == gymsList.length) {
        for(var gym in backupGyms) {
          if(gym.name != gymsList[backupGyms.indexOf(gym)].name) {
            gymChanged = true;
            break;
          }
        }
      }
      else {
        gymChanged = true;
      }
    }
  }

  deleteGyms(int index) async {
    bool success = false;
    gymChanged = true;
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a academia da lista?",
          firstButton: () {},
          secondButton: () {
            gymsList.removeAt(index);
            gymsList.sort((a, b) => a.name.compareTo(b.name));
            success = true;
          },
        );
      },
    );

    if(success) {
      SnackbarWidget(
        warningText: "Aviso",
        informationText: "Academia removida com sucesso",
        backgrondColor: AppColors.defaultColor,
        withPopup: true,
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
                images.add(
                  UserPictures(
                    userId: LoggedUser.id,
                    mainPicture: images.isEmpty,
                    base64: personImage,
                  ),
                );

                if(images.isNotEmpty && images.first.base64 != profileImagePath.value) {
                  profileImagePath.value = images.first.base64;
                  hasPicture.value = profileImagePath.value.isNotEmpty;
                  update(["profile-picture"]);
                }

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
            imageChanged = true;
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
    bool success = false;

    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Aviso",
          subTitle: "Tem certeza que deseja remover a imagem?",
          firstButton: () {},
          secondButton: () {
            images.removeAt(index);
            imageChanged = true;
            if(images.isNotEmpty && images.first.base64 != profileImagePath.value) {
              profileImagePath.value = images.first.base64;
            }
            else if(images.isEmpty) {
              profileImagePath.value = "";
            }
            hasPicture.value = profileImagePath.value.isNotEmpty;
            success = true;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
      },
    );

    if(success) {
      SnackbarWidget(
        warningText: "Aviso",
        informationText: "Imagem removida com sucesso",
        backgrondColor: AppColors.defaultColor,
        withPopup: true,
      );
    }
  }

  Future<bool> _updateUser() async {
    try {
      if(!await _userService.updateUser(user)) throw Exception();

      if(gymChanged) {
        if(!await _userGymService.deleteAllUserGymFromUser()) throw Exception();

        for(var gym in gymsList) {
          if(gym.id != null) {
            if(!await _gymService.checkIfGymExist(gym.id!)){
              if(!await _gymService.createGym(gym)) throw Exception();
            }

            if(!await _userGymService.checkIfUserGymExist(gym.id!)) {
              if(!await _userGymService.createUserGym(
                UserGym(userId: user.id!, gymId: gym.id!),
              )) throw Exception();
            }
          }
        }
      }

      if(imageChanged) {
        if(!await _pictureService.deleteAllPictureOfUser()) {
          throw Exception();
        }

        for(var image in images) {
          if(image.id == null || !await _pictureService.createPicture(
            UserPictures(
              base64: image.base64,
              mainPicture: images.indexOf(image) == 0,
              userId: user.id!,
            ),
          )) {
            throw Exception();
          }
        }
      }

      return true;
    }
    catch(_) {
      return false;
    }
  }

  Future<bool> _updateUserLocale() async {
    return await UserInformation.saveOptions(
      Person.update(
        name: user.name,
        userName: user.userName,
        aboutMe: user.aboutMe,
        gender: user.gender,
        birthdayDate: user.birthdayDate ?? DateTime.now(),
        cellphone: user.cellphone,
        email: user.email,
        id: user.id ?? LoggedUser.id,
      ),
    );
  }

  deleteAccount() async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          title: "Escolha uma das opções",
          subTitle: "Tem certeza que deseja apagar a sua conta?\nIsso irá apagar permanentemente todos os seus matchs, mensagens e fotos!",
          firstButtonText: "CANCELAR",
          secondButtonText: "APAGAR",
          firstButton: () {},
          secondButton: () => _deleteAccount(),
        );
      },
    );
  }

  _deleteAccount() async {
    try {
      await loadingWithSuccessOrErrorWidget.startAnimation();
      await Future.delayed(const Duration(seconds: 2));

      if(!await _userService.deleteUser() || !await UserInformation.deleteOptions()) throw Exception();

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Conta apagada com sucesso!",
          );
        },
      );
      Get.offAll(() => const LoginPage());
    }
    catch(_) {
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao apagar a sua conta!\nTente novamente mais tarde.",
          );
        },
      );
    }
  }

  closeProfile() {
    if(profileChanged) {
      Get.back(result: profileImagePath.value);
    }
    else {
      Get.back();
    }
  }
}