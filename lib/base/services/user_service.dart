import 'package:shared_preferences/shared_preferences.dart';
import '../models/person/person.dart';
import '../models/user/user.dart';
import '../models/userPictures/user_pictures.dart';
import '../viewControllers/authenticateResponse/authenticate_response.dart';
import '../viewControllers/forgetPasswordResponse/forget_password_response.dart';
import 'base/base_service.dart';
import 'interfaces/iuser_service.dart';

class UserService extends BaseService implements IUserService {
  @override
  Future<AuthenticateResponse?> authenticate({String? username, String? password}) async {
    try {
      httpClient.timeout = const Duration(seconds: 30);
      final sharedPreferences = await SharedPreferences.getInstance();
      username ??= sharedPreferences.getString('user_name');
      password ??= sharedPreferences.getString('password');

      if (username == null || password == null) throw Exception();

      final url = '${baseUrlApi}User/Authenticate';
      final response = await super.post(
        url,
        {
          "username": username,
          "password": password,
        },
      );

      if (hasErrorResponse(response)) throw Exception();

      return AuthenticateResponse.fromJson(response.body);
    }
    catch (_) {
      return null;
    }
  }

  @override
  Future<bool> createUser(User user) async {
    try {
      final url = '${baseUrlApi}User/CreateUser';
      final response = await super.post(url, user.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateUser(User user) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/UpdateUser';
      final response = await super.put(url, user.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkUserNameAlreadyRegistered(String userName) async {
    try {
      final url = '${baseUrlApi}User/CheckUserNameAlreadyRegistered';
      final response = await super.get(url, query: {"UserName": userName});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> checkCellphoneAlreadyRegistered(String cellphone) async {
    try {
      final url = '${baseUrlApi}User/CheckCellphoneAlreadyRegistered';
      final response = await super.get(url, query: {"Cellphone": cellphone});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> checkEmailAlreadyRegistered(String email) async {
    try {
      final url = '${baseUrlApi}User/CheckEmailAlreadyRegistered';
      final response = await super.get(url, query: {"Email": email});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Person?> getUserInformation(String userName) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/GetUserInformation';
      final response = await super.get(url, query: {"UserName": userName}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return Person.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserPictures?> getUserProfilePicture() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/GetUserProfilePicture';
      final response = await super.get(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return UserPictures.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Person>?> getNextFiveUsers(int skip) async {
    try {
      httpClient.timeout = const Duration(seconds: 45);
      final token = await getToken();
      final url = '${baseUrlApi}User/GetNextFiveUsers';
      final response = await super.get(url, query: {"Skip": skip.toString()}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      var peopleList = (response.body as List).map((e) => Person.fromJson(e)).toList();
      peopleList.sort((a, b) {
        if(a.distance != null &&  b.distance != null) {
          return a.distance!.compareTo(b.distance!);
        }
        return peopleList.length - 1;
      });
      return peopleList;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ForgetPasswordResponse?> validationForgetPasswordCode(String userEmail, String code) async {
    try {
      final url = '${baseUrlApi}User/ValidationForgetPasswordCode';
      final response = await super.put(url, null, query: {"UserEmail": userEmail, "Code": code});
      if (hasErrorResponse(response)) throw Exception();
      return ForgetPasswordResponse.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ForgetPasswordResponse?> forgetPassword(String userEmail) async {
    try {
      final url = '${baseUrlApi}User/ForgetPassword';
      final response = await super.put(url, null, query: {"UserEmail": userEmail});
      if (hasErrorResponse(response)) throw Exception();
      return ForgetPasswordResponse.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> forgetPasswordWithId(String userId, String password) async {
    try {
      final url = '${baseUrlApi}User/ForgetPasswordWithId';
      final response = await super.put(url, null, query: {"UserId": userId, "Password": password});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> forgetPasswordInternal(String password) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/ForgetPasswordInternal';
      final response = await super.put(url, null, query: {"Password": password}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/DeleteUser';
      final response = await super.delete(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body as bool;
    } catch (_) {
      return false;
    }
  }
}