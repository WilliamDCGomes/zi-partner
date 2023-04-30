import 'package:age_calculator/age_calculator.dart';
import '../../../app/enums/enums.dart';

class LoggedUser {
  static String id = "";
  static String name = "";
  static String nameInitials = "";
  static String nameAndLastName = "";
  static String birthdate = "";
  static String cpf = "";
  static TypeGender gender = TypeGender.none;
  static String cep = "";
  static String uf = "";
  static String city = "";
  static String street = "";
  static String? houseNumber = "";
  static String neighborhood = "";
  static String complement = "";
  static String? phone = "";
  static String? cellPhone = "";
  static String email = "";
  static String password = "";
  static DateTime? includeDate;

  static String get userAge {
    try{
      var bithdayUsaVersion = birthdate.split('/');
      DateTime userBirthday = DateTime.parse("${bithdayUsaVersion[2]}-${bithdayUsaVersion[1]}-${bithdayUsaVersion[0]}");
      DateDuration age = AgeCalculator.age(userBirthday);
      return ", ${age.years}";
    }
    catch(_){
      return "";
    }
  }
}