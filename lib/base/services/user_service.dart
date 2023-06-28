import 'package:shared_preferences/shared_preferences.dart';
import '../models/person/person.dart';
import '../models/user/user.dart';
import '../viewControllers/authenticateResponse/authenticate_response.dart';
import 'base/base_service.dart';
import 'interfaces/iuser_service.dart';

class UserService extends BaseService implements IUserService {
  @override
  Future<AuthenticateResponse?> authenticate({String? username, String? password}) async {
    try {
      httpClient.timeout = const Duration(seconds: 30);
      final sharedPreferences = await SharedPreferences.getInstance();
      username ??= sharedPreferences.getString('user_logged');
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
  Future<User?> getUserInformation(String userName) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/GetUserInformation';
      final response = await super.get(url, query: {"UserName": userName}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return User.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Person>?> getNextFiveUsers(int skip) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}User/GetNextFiveUsers';
      final response = await super.get(url, query: {"Skip": skip.toString()}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Person.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> forgetPassword(String userName, String password) async {
    try {
      final url = '${baseUrlApi}User/ForgetPassword';
      final response = await super.put(url, null, query: {"UserName": userName, "Password": password});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> forgetPasswordInternal(String password) async {
    try {
      final url = '${baseUrlApi}User/ForgetPasswordInternal';
      final response = await super.put(url, null, query: {"Password": password});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteUser(String userId) async {
    try {
      final url = '${baseUrlApi}User/DeleteUser';
      final response = await super.delete(url, query: {"UserId": userId});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }
}