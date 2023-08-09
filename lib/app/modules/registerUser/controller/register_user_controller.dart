import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';
import 'package:zi_partner/app/enums/enums.dart';
import 'package:zi_partner/base/models/gym/gym.dart';
import 'package:zi_partner/base/models/user/user.dart';
import 'package:zi_partner/base/models/userGym/user_gym.dart';
import 'package:zi_partner/base/services/gym_service.dart';
import 'package:zi_partner/base/services/interfaces/igym_service.dart';
import 'package:zi_partner/base/services/picture_service.dart';
import 'package:zi_partner/base/services/user_gym_service.dart';
import 'package:zi_partner/base/services/user_service.dart';
import '../../../../base/models/userPictures/user_pictures.dart';
import '../../../../base/services/interfaces/ipicture_service.dart';
import '../../../../base/services/interfaces/iuser_gym_service.dart';
import '../../../../base/services/interfaces/iuser_service.dart';
import '../../../selectGyms/page/select_gyms_page.dart';
import '../../../utils/helpers/date_format_to_brazil.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
import '../../../utils/helpers/send_location.dart';
import '../../../utils/helpers/valid_cellphone_mask.dart';
import '../../../utils/helpers/view_picture.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';
import '../../../utils/sharedWidgets/popups/confirmation_popup.dart';
import '../../../utils/sharedWidgets/popups/information_popup.dart';
import '../../../utils/sharedWidgets/snackbar_widget.dart';
import '../../../utils/stylePages/app_colors.dart';
import '../../login/page/login_page.dart';
import '../widgets/body_register_stepper_widget.dart';
import '../widgets/header_register_stepper_widget.dart';

class RegisterUserController extends GetxController {
  late String lgpdPhrase;
  late RxInt activeStep;
  late RxBool passwordFieldEnabled;
  late RxBool confirmPasswordFieldEnabled;
  late RxBool nameInputHasError;
  late RxBool loginInputHasError;
  late RxBool birthdayInputHasError;
  late RxBool cellPhoneInputHasError;
  late RxBool emailInputHasError;
  late RxBool confirmEmailInputHasError;
  late RxBool passwordInputHasError;
  late RxBool confirmPasswordInputHasError;
  late RxString genderSelected;
  late List<String> genderList;
  late RxList<Gym> gyms;
  late RxList<String> images;
  late final GlobalKey<FormState> formKeyPersonalInformation;
  late final GlobalKey<FormState> formKeyContactInformation;
  late final GlobalKey<FormState> formKeyAddressInformation;
  late final GlobalKey<FormState> formKeyPasswordInformation;
  late final TextEditingController nameTextController;
  late final TextEditingController userNameTextController;
  late final TextEditingController birthDateTextController;
  late final TextEditingController cellPhoneTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController confirmEmailTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;
  late final TextEditingController aboutMeTextController;
  late final SingleValueDropDownController gymNameTextController;
  late final FocusNode loginFocusNode;
  late final FocusNode birthDateFocusNode;
  late final FocusNode cellPhoneFocusNode;
  late final FocusNode emailFocusNode;
  late final FocusNode confirmEmailFocusNode;
  late final FocusNode confirmPasswordFocusNode;
  late MaskTextInputFormatter maskCellPhoneFormatter;
  late List<HeaderRegisterStepperWidget> headerRegisterStepperList;
  late List<BodyRegisterStepperWidget> bodyRegisterStepperList;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late ScrollController imagesListController;
  late User newUser;
  late IUserService _userService;
  late IGymService _gymService;
  late IUserGymService _userGymService;
  late IPictureService _pictureService;

  RegisterUserController(){
    _initializeVariables();
  }

  _initializeVariables(){
    lgpdPhrase = "Ao avançar, você esta de acordo e concorda com as Políticas de Privacidade e com os Termos de Serviço.";
    activeStep = 0.obs;
    genderSelected = "".obs;
    passwordFieldEnabled = true.obs;
    confirmPasswordFieldEnabled = true.obs;
    nameInputHasError = false.obs;
    loginInputHasError = false.obs;
    birthdayInputHasError = false.obs;
    cellPhoneInputHasError = false.obs;
    emailInputHasError = false.obs;
    confirmEmailInputHasError = false.obs;
    passwordInputHasError = false.obs;
    confirmPasswordInputHasError = false.obs;
    images = <String>[].obs;
    gyms = <Gym>[].obs;
    genderList = [
      "Masculino",
      "Feminino",
    ];
    maskCellPhoneFormatter = MasksForTextFields.phoneNumberAcceptExtraNumberMask;
    formKeyPersonalInformation = GlobalKey<FormState>();
    formKeyContactInformation = GlobalKey<FormState>();
    formKeyAddressInformation = GlobalKey<FormState>();
    formKeyPasswordInformation = GlobalKey<FormState>();
    nameTextController = TextEditingController();
    userNameTextController = TextEditingController();
    birthDateTextController = TextEditingController();
    cellPhoneTextController = TextEditingController();
    emailTextController = TextEditingController();
    confirmEmailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    aboutMeTextController = TextEditingController();
    gymNameTextController = SingleValueDropDownController();
    loginFocusNode = FocusNode();
    birthDateFocusNode = FocusNode();
    cellPhoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    confirmEmailFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    imagesListController = ScrollController();
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    headerRegisterStepperList = const [
      HeaderRegisterStepperWidget(
        firstText: "PASSO 1 DE 6",
        secondText: "Dados Pessoais",
        thirdText: "Informe os dados pessoais para continuar o cadastro.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 2 DE 6",
        secondText: "Senha de Acesso",
        thirdText: "Crie uma senha para realizar o acesso na plataforma.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 3 DE 6",
        secondText: "Dados de Contato",
        thirdText: "Preencha os dados de contato para que seja possível a comunicação.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 4 DE 6",
        secondText: "Academias Frequentadas",
        thirdText: "Adicione as academias que você costuma frequentar.",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 5 DE 6",
        secondText: "Fotos",
        thirdText: "Adicione as suas fotos no aplicativo (Máximo de 6 fotos).",
      ),
      HeaderRegisterStepperWidget(
        firstText: "PASSO 6 DE 6",
        secondText: "Sobre mim",
        thirdText: "Fale um pouco sobre você e como é o seu treino.",
      ),
    ];
    bodyRegisterStepperList = [
      BodyRegisterStepperWidget(
        indexView: 0,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 1,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 2,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 3,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 4,
        controller: this,
      ),
      BodyRegisterStepperWidget(
        indexView: 5,
        controller: this,
      ),
    ];
    _userService = UserService();
    _gymService = GymService();
    _userGymService = UserGymService();
    _pictureService = PictureService();
    newUser = User.empty();
  }

  _validPersonalInformationAndAdvanceNextStep() async {
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
    }
    else if(await _userService.checkUserNameAlreadyRegistered(userNameTextController.text)){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return InformationPopup(
            warningMessage: "O login \"${userNameTextController.text.toUpperCase()}\" já está cadastrado no sistema. Informe um diferente!",
          );
        },
      );
    }
    else{
      newUser.name = nameTextController.text;
      newUser.userName = userNameTextController.text;
      newUser.birthdayDate = DateFormatToBrazil.formatDateFromTextField(birthDateTextController.text);
      newUser.gender = genderSelected.value == "Masculino" ? TypeGender.masculine : TypeGender.feminine;
      _nextPage();
    }
  }

  _validEmailAndAdvanceNextStep() async {
    if(await _userService.checkCellphoneAlreadyRegistered(cellPhoneTextController.text)){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "O número do celular já está cadastrado no sistema.",
          );
        },
      );
    }
    else if(await _userService.checkEmailAlreadyRegistered(emailTextController.text)){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "O E-mail já está cadastrado no sistema.",
          );
        },
      );
    }
    else{
      newUser.cellphone = cellPhoneTextController.text;
      newUser.email = emailTextController.text;
      _nextPage();
    }
  }

  _nextPage() async {
    if(activeStep.value < 5) {
      activeStep.value ++;
    } else {
      /*var status = await OneSignal.shared.getDeviceState();
      newUser.playerId = status != null ? status.userId ?? "" : "";
      LoggedUser.playerId = newUser.playerId;*/
      newUser.playerId = const Uuid().v4();
      await _saveUser();
    }
  }

  nextButtonPressed() async {
    if(!await InternetConnection.validInternet(
      "É necessário uma conexão com a internet para fazer o cadastro",
      loadingWithSuccessOrErrorWidget,
    )){
      return;
    }
    switch(activeStep.value){
      case 0:
        if(formKeyPersonalInformation.currentState!.validate()){
          await Loading.startAndPauseLoading(
            () => _validPersonalInformationAndAdvanceNextStep(),
            loadingWithSuccessOrErrorWidget,
          );
        }
        break;
      case 1:
        if(formKeyPasswordInformation.currentState!.validate()){
          newUser.password = passwordTextController.text;
          _nextPage();
        }
        break;
      case 2:
        if(formKeyContactInformation.currentState!.validate()){
          Loading.startAndPauseLoading(
            () => _validEmailAndAdvanceNextStep(),
            loadingWithSuccessOrErrorWidget,
          );
        }
        break;
      case 3:
        if(gyms.isEmpty){
          await showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return ConfirmationPopup(
                title: "Aviso",
                subTitle: "Você não adicionou nenhuma academia na sua lista, tem certeza que deseja continuar?",
                firstButton: () {},
                secondButton: () => _nextPage(),
              );
            },
          );
        }
        else {
          _nextPage();
        }
        break;
      case 4:
        if(images.isEmpty){
          await showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return ConfirmationPopup(
                title: "Aviso",
                subTitle: "Você não adicionou nenhuma imagem no seu perfil, tem certeza que deseja continuar?",
                firstButton: () {},
                secondButton: () => _nextPage(),
              );
            },
          );
        }
        else {
          _nextPage();
        }
        break;
      case 5:
        if(aboutMeTextController.text.isEmpty){
          await showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return ConfirmationPopup(
                title: "Aviso",
                subTitle: "Você não disse nada sobre você, tem certeza que deseja finalizar?",
                firstButton: () {},
                secondButton: () => _nextPage(),
              );
            },
          );
        }
        else {
          newUser.aboutMe = aboutMeTextController.text;
          _nextPage();
        }
        break;
    }
  }

  backButtonPressed() async {
    int currentIndex = activeStep.value;
    if (activeStep.value > 0) {
      activeStep.value--;
    }

    return await Future.delayed(
      const Duration(
        milliseconds: 100
      ),
      () {
        return currentIndex <= 0;
      }
    );
  }

  backButtonOverridePressed() {
    if (activeStep.value > 0) {
      activeStep.value--;
    }
    else {
      Get.back();
    }
  }

  phoneTextFieldEdited(String cellPhoneTyped){
    cellPhoneTextController.value = ValidCellPhoneMask.updateCellPhoneMask(
      cellPhoneTyped,
      maskCellPhoneFormatter,
    );
  }

  addGyms() async {
    await Get.to(() => SelectGymsPage(selectedGyms: gyms,));
    gyms.sort((a, b) => a.name.compareTo(b.name));
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
      gyms.removeAt(index);
      gyms.sort((a, b) => a.name.compareTo(b.name));
      SnackbarWidget(
        warningText: "Aviso",
        informationText: "Academia removido da lista com sucesso",
        backgrondColor: AppColors.defaultColor,
        withPopup: true,
      );
    }
  }

  addNewPicture() async {
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
    } catch (_) {
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

  _saveUser() async {
    try {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      await loadingWithSuccessOrErrorWidget.startAnimation();

      if(!await _userService.createUser(newUser)) throw Exception();

      for(var gym in gyms) {
        if(gym.id != null && !await _gymService.checkIfGymExist(gym.id!)){
          if(!await _gymService.createGym(gym)) throw Exception();
        }
        if(!await _userGymService.createUserGym(UserGym(userId: newUser.id!, gymId: gym.id!))) throw Exception();
      }

      await SendLocation.sendUserLocation(newUser.id!);

      for(var image in images) {
        var result = await _pictureService.createPicture(
          UserPictures(
            base64: image,
            mainPicture: images.indexOf(image) == 0,
            userId: newUser.id!,
          ),
        );
        if(!result) throw Exception();
      }

      await loadingWithSuccessOrErrorWidget.stopAnimation();
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Cadastro realizado com sucesso!",
            success: true,
          );
        },
      );
      Get.offAll(() => const LoginPage(cancelFingerPrint: true,));
    }
    catch(_){
      await loadingWithSuccessOrErrorWidget.stopAnimation(fail: true);
      await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "Erro ao cadastrar usuário.\n Tente novamente mais tarde",
          );
        },
      );
    }
  }
}