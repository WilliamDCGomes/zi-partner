import 'package:age_calculator/age_calculator.dart';
import '../../../app/enums/enums.dart';

class LoggedUser {
  static String id = "";
  static String _name = "";
  static String nameInitials = "";
  static String nameAndLastName = "";
  static String birthdate = "";
  static TypeGender gender = TypeGender.none;
  static String cep = "";
  static String uf = "";
  static String city = "";
  static String street = "";
  static String? houseNumber = "";
  static String neighborhood = "";
  static String complement = "";
  static String? cellPhone = "";
  static String email = "";
  static String password = "";
  static DateTime? includeDate;

  static String get name => _name;

  static set name(String value) {
    _name = value;

    var names = value.trim().split(" ");

    if(names.isNotEmpty && names.first != ""){
      nameInitials = names.first[0];
      nameAndLastName = names.first;
      if(names.length > 1 && names.last != ""){
        nameInitials += names.last[0];
        nameAndLastName += " ${names.last}";
      }
    }
    else{
      nameInitials = "NI";
    }
  }

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