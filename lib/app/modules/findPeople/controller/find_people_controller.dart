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
        aboutMe: "Ut vulputate eget ipsum et suscipit. Nullam ex ante, porta a sem eu, molestie pharetra risus. Nulla ut lacus risus. Suspendisse fringilla lobortis condimentum. Sed et ligula elit. Etiam ex mi, posuere vel lectus ac, sollicitudin dignissim quam. Pellentesque luctus tempor eleifend. Curabitur sit amet est id turpis blandit blandit. Fusce ut lectus ut diam rhoncus sagittis. Suspendisse felis ipsum, pulvinar eu auctor et, tincidunt id purus. Fusce volutpat nisl eu leo congue, vitae pulvinar neque condimentum.",
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
        aboutMe: "Maecenas hendrerit eros gravida, posuere erat non, consectetur nibh. Phasellus ornare ornare enim. Maecenas eleifend laoreet gravida. Vivamus in neque in lectus dignissim porta. Proin laoreet accumsan sodales. Praesent ut lorem ullamcorper, pretium nisi varius, mattis orci. Vivamus sed consectetur lorem. Pellentesque commodo libero ac enim laoreet pellentesque. In tristique, magna sit amet feugiat auctor, velit ipsum posuere neque, vulputate tempus magna felis nec tellus. Aenean pellentesque iaculis varius. Duis et lacinia erat. Ut ultricies mi et purus ornare posuere. Vestibulum non elit nec lectus condimentum lobortis et quis velit.",
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
        aboutMe: "Pellentesque ornare sem a nibh sodales sollicitudin. Mauris sed quam magna. Vivamus purus ligula, semper eu quam mollis, convallis volutpat dolor. Sed consequat ornare nibh, eget molestie dui pellentesque a. Aliquam sit amet tellus et ex pharetra vulputate eu a nibh. Donec blandit est libero. Vivamus finibus egestas nibh, eget mollis mauris pharetra at. Vivamus ac metus metus. Vestibulum in dictum neque. Vivamus laoreet euismod auctor. Aenean ultricies velit non mi feugiat sodales. Pellentesque euismod porta condimentum. Nulla faucibus aliquam mi, et consequat erat ornare a. Nullam in ipsum ut metus suscipit posuere.",
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
        aboutMe: "Proin eu elit est. Curabitur malesuada est dolor, id interdum mauris accumsan nec. Suspendisse ultricies dui at semper convallis. Proin vulputate nibh at ante pharetra vestibulum. Aenean eget rutrum magna. Proin egestas et augue et porta. Maecenas et nulla vulputate, posuere lorem ut, tincidunt sem.",
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
        aboutMe: "Proin eu elit est. Curabitur malesuada est dolor, id interdum mauris accumsan nec. Suspendisse ultricies dui at semper convallis. Proin vulputate nibh at ante pharetra vestibulum. Aenean eget rutrum magna. Proin egestas et augue et porta. Maecenas et nulla vulputate, posuere lorem ut, tincidunt sem. Etiam molestie egestas libero, sit amet faucibus arcu. Cras ornare semper imperdiet. Cras laoreet neque volutpat nunc fermentum sagittis. Morbi pretium fermentum lacus, eu vehicula augue fringilla sit amet. Suspendisse in nibh vel nibh luctus aliquet. Integer non eros dui.",
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
      ),
    ].obs;
    peopleList.sort((a, b) => a.distance.compareTo(b.distance));
  }
}
