import 'package:get/get.dart';
import 'package:zi_partner/app/enums/enums.dart';
import '../../../../base/models/person/person.dart';
import '../../../utils/helpers/paths.dart';

class FindPeopleController extends GetxController {
  late RxList<Person> peopleList;

  FindPeopleController() {
    _initializeVariables();
  }

  _initializeVariables(){
    peopleList = [
      Person(
        name: "Carol Gonçalves Baceno",
        userName: "Carolzinha",
        longitude: "",
        latitude: "",
        distance: 11.4,
        gender: TypeGender.feminine,
        gyms: [
          "Alameda Fit",
          "Smart Fit"
        ],
        picture: [
          Paths.foto1Perfil1,
          Paths.foto2Perfil1,
          Paths.foto3Perfil1,
        ],
      ),
      Person(
        name: "Carlos Roberto",
        userName: "Robertinho",
        longitude: "",
        latitude: "",
        distance: 5.6,
        gender: TypeGender.masculine,
        gyms: [
          "Eleven Fit",
          "Smart Fit"
        ],
        picture: [
          Paths.foto1Perfil2,
          Paths.foto2Perfil2,
          Paths.foto3Perfil2,
        ],
      ),
      Person(
        name: "Adriana Ribeiro",
        userName: "DriiRibeiro",
        longitude: "",
        latitude: "",
        distance: 13.4,
        gender: TypeGender.feminine,
        gyms: [
          "Red Fit",
          "Eleven Fit"
        ],
        picture: [
          Paths.foto1Perfil3,
          Paths.foto2Perfil3,
          Paths.foto3Perfil3,
        ],
      ),
      Person(
        name: "Lidiane Maranhão",
        userName: "LiliMa",
        longitude: "",
        latitude: "",
        distance: 1.5,
        gender: TypeGender.feminine,
        gyms: [
          "Red Fit",
        ],
        picture: [
          Paths.foto1Perfil4,
          Paths.foto2Perfil4,
          Paths.foto3Perfil4,
        ],
      ),
      Person(
        name: "Mauricio Ramos",
        userName: "RaMaCi",
        longitude: "",
        latitude: "",
        distance: 25.8,
        gender: TypeGender.masculine,
        gyms: [
          "Pulse Fit",
        ],
        picture: [
          Paths.foto1Perfil5,
          Paths.foto2Perfil5,
          Paths.foto3Perfil5,
        ],
      ),
      Person(
        name: "Vinicius Tronvone",
        userName: "TronCius",
        longitude: "",
        latitude: "",
        distance: 26.2,
        gender: TypeGender.masculine,
        gyms: [
          "Smart Fit"
        ],
        picture: [
          Paths.foto1Perfil6,
          Paths.foto2Perfil6,
          Paths.foto3Perfil6,
        ],
      ),
      Person(
        name: "Marcos Aurério",
        userName: "Mario",
        longitude: "",
        latitude: "",
        distance: 26.5,
        gender: TypeGender.masculine,
        gyms: [],
        picture: [],
      ),
    ].obs;
    peopleList.sort((a, b) => a.distance.compareTo(b.distance));
  }
}
