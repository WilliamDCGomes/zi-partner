import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zi_partner/app/utils/helpers/paths.dart';
import '../models/user/user.dart';
import '../viewControllers/authenticateResponse/authenticate_response.dart';
import 'base/base_service.dart';
import 'interfaces/iuser_service.dart';

class UserService extends BaseService implements IUserService {

  @override
  Future<String> getUserProfilePicture() async {
    try{
      return Paths.profilePicture;
    }
    catch(_){
      return "";
    }
  }

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
        null,
        query: {
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

  Future<List<User>> getAll() async {
    try {
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<bool> createUser(User user) async {
    try {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> editUser(User user) async {
    try {
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User?> getUser(String cpf) async {
    try {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String> getCpf(int studentRa) async {
    try {
      return "";
    } catch (_) {
      return "";
    }
  }

  @override
  Future<String> getEmail(String userCpf) async {
    try {
      return "";
    } catch (_) {
      return "";
    }
  }

  @override
  Future<String> getName(String userCpf) async {
    try {
      return "";
    } catch (_) {
      return "";
    }
  }

  @override
  Future<bool> registerNewUser(String email, String password) async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updatePassword(String newPassword) async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> loggedUser() async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> loginUser(String email, String password) async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> logoutUser() async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> forgetPasswordInternal(String password) async {
    try {
      return true;
    } catch (_) {
      return false;
    }
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}