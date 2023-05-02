import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../base/models/addressInformation/address_information.dart';
import '../../../../base/services/consult_cep_service.dart';
import '../../../../base/services/interfaces/iconsult_cep_service.dart';
import '../../../utils/helpers/brazil_address_informations.dart';
import '../../../utils/helpers/internet_connection.dart';
import '../../../utils/helpers/loading.dart';
import '../../../utils/helpers/masks_for_text_fields.dart';
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
  late RxBool loadingAnimation;
  late RxBool confirmPasswordFieldEnabled;
  late RxBool nameInputHasError;
  late RxBool userNameInputHasError;
  late RxBool birthdayInputHasError;
  late RxBool cepInputHasError;
  late RxBool cityInputHasError;
  late RxBool streetInputHasError;
  late RxBool neighborhoodInputHasError;
  late RxBool cellPhoneInputHasError;
  late RxBool emailInputHasError;
  late RxBool confirmEmailInputHasError;
  late RxBool passwordInputHasError;
  late RxBool confirmPasswordInputHasError;
  late RxString ufSelected;
  late RxString genderSelected;
  late List<String> genderList;
  late RxList<String> ufsList;
  late RxList<String> gymsList;
  late RxList<String> images;
  late final GlobalKey<FormState> formKeyPersonalInformation;
  late final GlobalKey<FormState> formKeyAddressInformation;
  late final GlobalKey<FormState> formKeyContactInformation;
  late final GlobalKey<FormState> formKeyPasswordInformation;
  late MaskTextInputFormatter maskCellPhoneFormatter;
  late TextEditingController nameTextController;
  late TextEditingController userNameTextController;
  late TextEditingController birthDateTextController;
  late TextEditingController cepTextController;
  late TextEditingController cityTextController;
  late TextEditingController streetTextController;
  late TextEditingController houseNumberTextController;
  late TextEditingController neighborhoodTextController;
  late TextEditingController complementTextController;
  late TextEditingController cellPhoneTextController;
  late TextEditingController emailTextController;
  late TextEditingController confirmEmailTextController;
  late TextEditingController passwordTextController;
  late TextEditingController confirmPasswordTextController;
  late TextEditingController gymNameTextController;
  late TextEditingController aboutMeTextController;
  late FocusNode userNameFocusNode;
  late FocusNode birthDateFocusNode;
  late FocusNode streetFocusNode;
  late FocusNode houseNumberFocusNode;
  late FocusNode neighborhoodFocusNode;
  late FocusNode complementFocusNode;
  late FocusNode cellPhoneFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode confirmEmailFocusNode;
  late FocusNode confirmPasswordFocusNode;
  late List<HeaderRegisterStepperWidget> headerRegisterStepperList;
  late List<BodyRegisterStepperWidget> bodyRegisterStepperList;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late ScrollController imagesListController;
  late IConsultCepService _consultCepService;

  RegisterUserController(){
    _initializeVariables();
  }

  @override
  void onInit() async {
    await _getUfsNames();
    super.onInit();
  }

  _initializeVariables(){
    lgpdPhrase = "Ao avançar, você esta de acordo e concorda com as Políticas de Privacidade e com os Termos de Serviço.";
    activeStep = 0.obs;
    ufSelected = "".obs;
    genderSelected = "".obs;
    loadingAnimation = false.obs;
    passwordFieldEnabled = true.obs;
    confirmPasswordFieldEnabled = true.obs;
    nameInputHasError = false.obs;
    userNameInputHasError = false.obs;
    birthdayInputHasError = false.obs;
    cepInputHasError = false.obs;
    cityInputHasError = false.obs;
    streetInputHasError = false.obs;
    neighborhoodInputHasError = false.obs;
    cellPhoneInputHasError = false.obs;
    emailInputHasError = false.obs;
    confirmEmailInputHasError = false.obs;
    passwordInputHasError = false.obs;
    confirmPasswordInputHasError = false.obs;
    ufsList = <String>[].obs;
    gymsList = <String>[].obs;
    images = <String>[].obs;
    genderList = [
      "Masculino",
      "Feminino",
    ];
    maskCellPhoneFormatter = MasksForTextFields.phoneNumberAcceptExtraNumberMask;
    formKeyPersonalInformation = GlobalKey<FormState>();
    formKeyAddressInformation = GlobalKey<FormState>();
    formKeyContactInformation = GlobalKey<FormState>();
    formKeyPasswordInformation = GlobalKey<FormState>();
    nameTextController = TextEditingController();
    userNameTextController = TextEditingController();
    birthDateTextController = TextEditingController();
    cepTextController = TextEditingController();
    cityTextController = TextEditingController();
    streetTextController = TextEditingController();
    houseNumberTextController = TextEditingController();
    neighborhoodTextController = TextEditingController();
    complementTextController = TextEditingController();
    cellPhoneTextController = TextEditingController();
    emailTextController = TextEditingController();
    confirmEmailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    gymNameTextController = TextEditingController();
    aboutMeTextController = TextEditingController();
    userNameFocusNode = FocusNode();
    birthDateFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    houseNumberFocusNode = FocusNode();
    neighborhoodFocusNode = FocusNode();
    complementFocusNode = FocusNode();
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
    _consultCepService = ConsultCepService();
  }

  searchAddressInformation() async {
    try{
      if(cepTextController.text.length == 9){
        AddressInformation? addressInformation = await _consultCepService.searchCep(cepTextController.text);
        if(addressInformation != null){
          ufSelected.value = addressInformation.uf;
          cityTextController.text = addressInformation.localidade;
          streetTextController.text = addressInformation.logradouro;
          neighborhoodTextController.text = addressInformation.bairro;
          complementTextController.text = addressInformation.complemento;
          formKeyAddressInformation.currentState!.validate();
        }
        else{
          throw Exception();
        }
      }
    }
    catch(_){
      ufSelected.value = "";
      cityTextController.text = "";
      streetTextController.text = "";
      neighborhoodTextController.text = "";
      complementTextController.text = "";
    }
  }

  _getUfsNames() async {
    try{
      ufsList.clear();
      List<String> states = await BrazilAddressInformations.getUfsNames();
      for(var uf in states) {
        ufsList.add(uf);
      }
    }
    catch(_){
      ufsList.clear();
    }
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
    /*else if(await studentService.verificationStudentExists(cpfTextController.text)){
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const InformationPopup(
            warningMessage: "O CPF já está cadastrado no sistema.",
          );
        },
      );
    }*/
    else{
      /*newUser.name = nameTextController.text;
      newUser.birthdate = birthDateTextController.text;
      newUser.cpf = cpfTextController.text;
      newStudent.cpf = cpfTextController.text;
      newUser.gender = genderSelected.value;*/
      _nextPage();
    }
  }

  _validEmailAndAdvanceNextStep() async {
    if(false){//await studentService.verificationEmailExists(emailTextController.text)){
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
      /*newUser.phone = phoneTextController.text;
      newUser.cellPhone = cellPhoneTextController.text;
      newUser.email = emailTextController.text;*/
      _nextPage();
    }
  }

  _nextPage() async {
    if(activeStep.value < 5) {
      activeStep.value ++;
    } else {
      await _saveUser();
    }
  }

  _saveUser() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    loadingAnimation.value = true;
    await loadingWithSuccessOrErrorWidget.startAnimation();

    await Future.delayed(const Duration(seconds: 1));

    try {
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
      Get.offAll(() => const LoginPage());
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
          //newStudent.password = passwordTextController.text;
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
        if(gymsList.isEmpty){
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

  addGyms() {
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
}