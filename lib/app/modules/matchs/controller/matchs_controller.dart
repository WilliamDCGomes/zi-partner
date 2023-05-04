import 'package:get/get.dart';
import '../../../../base/models/person/person.dart';
import '../../../enums/enums.dart';
import '../../../utils/helpers/paths.dart';

class MatchsController extends GetxController {
  late RxList<Person> matchsList;

  MatchsController() {
    _initializeVariables();
  }

  _initializeVariables() {
    matchsList = <Person>[

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
        lastMessage: "Em qual academia você treina?",
        aboutMe: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempor euismod est, eu pulvinar felis finibus iaculis. Sed ex libero, consectetur ut tellus a, bibendum rhoncus sapien. Ut interdum lacus id justo cursus, at volutpat odio placerat. Etiam molestie egestas libero, sit amet faucibus arcu. Cras ornare semper imperdiet. Cras laoreet neque volutpat nunc fermentum sagittis. Morbi pretium fermentum lacus, eu vehicula augue fringilla sit amet. Suspendisse in nibh vel nibh luctus aliquet. Integer non eros dui.",
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
        lastMessage: "Segunda-Feira, você pode?",
        aboutMe: "Proin eu elit est. Curabitur malesuada est dolor, id interdum mauris accumsan nec. Suspendisse ultricies dui at semper convallis. Proin vulputate nibh at ante pharetra vestibulum. Aenean eget rutrum magna. Proin egestas et augue et porta. Maecenas et nulla vulputate, posuere lorem ut, tincidunt sem.",
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
        aboutMe: "",
        lastMessage: "Combinado!",
      ),
    ].obs;
  }
}
