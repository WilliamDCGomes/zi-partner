import 'package:shared_preferences/shared_preferences.dart';
import '../../../base/models/loggedUser/logged_user.dart';
import '../../../base/models/person/person.dart';
import '../../enums/enums.dart';
import 'date_format_to_brazil.dart';

class SaveUserInformations {
  static Future<bool> saveOptions(Person? user, {String? password, bool? keepConected}) async {
    try {
      if(user != null) {
        var sharedPreferences = await SharedPreferences.getInstance();
        String? oldUser = sharedPreferences.getString("user_logged");
        if (oldUser == null) {
          await sharedPreferences.setString("user_logged", user.userName);
        }
        else if (oldUser != user.userName) {
          var token = sharedPreferences.getString('Token');
          var expiracaoToken = sharedPreferences.getString('ExpiracaoToken');
          await sharedPreferences.clear();
          await sharedPreferences.setString("user_logged", user.userName);
          if(token != null) {
            await sharedPreferences.setString('Token', token);
          }
          if(expiracaoToken != null) {
            await sharedPreferences.setString('ExpiracaoToken', expiracaoToken);
          }
        }
        if(keepConected != null) {
          await sharedPreferences.setBool("keep-connected", keepConected);
        }
        if(user.cellphone != null) {
          await sharedPreferences.setString("cellPhone", user.cellphone!);
        }
        if(user.email != null) {
          await sharedPreferences.setString("email", user.email!);
        }
        await sharedPreferences.setString("name", user.name);
        await sharedPreferences.setString("birthdate", DateFormatToBrazil.formatDate(user.birthdayDate));
        await sharedPreferences.setString("user_name_and_last_name", user.name);
        await sharedPreferences.setString("user_name", user.name.split(' ').first);
        await sharedPreferences.setString("user_id", user.id);
        switch (user.gender) {
          case TypeGender.masculine:
            await sharedPreferences.setString("gender", "Masculino");
            break;
          case TypeGender.feminine:
            await sharedPreferences.setString("gender", "Feminino");
            break;
          case TypeGender.none:
            await sharedPreferences.setString("gender", "Não Informado");
            break;
        }

        LoggedUser.birthdayDate = DateFormatToBrazil.formatDate(user.birthdayDate);
        LoggedUser.gender = user.gender;
        LoggedUser.cellPhone = user.cellphone ;
        LoggedUser.email = user.email ?? "";
        LoggedUser.nameAndLastName = user.name;
        LoggedUser.name = user.name.split(' ').first;
        LoggedUser.userName = user.userName;
        LoggedUser.id = user.id;
        if(password != null && password.isNotEmpty) {
          LoggedUser.password = password;
          await sharedPreferences.setString("password", password);
        }

        return true;
      }
      return false;
    }
    catch(_) {
      return false;
    }
  }
}
