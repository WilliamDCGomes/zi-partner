import '../models/user/user.dart';
import '../viewControllers/authenticateResponse/authenticate_response.dart';
import 'base/base_service.dart';
import 'interfaces/iuser_service.dart';

class UserService extends BaseService implements IUserService {
  @override
  Future<AuthenticateResponse?> authenticate({String? username, String? password}) async {
    return null;
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
