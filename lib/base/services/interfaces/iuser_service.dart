import '../../models/user/user.dart';
import '../../viewControllers/authenticateResponse/authenticate_response.dart';

abstract class IUserService {
  Future<AuthenticateResponse?> authenticate({String? username, String? password});

  Future<bool> createUser(User user);

  Future<bool> updateUser(User user);

  Future<User?> getUserInformation(String userName);

  Future<bool> forgetPassword(String userName, String password);

  Future<bool> forgetPasswordInternal(String password);

  Future<bool> deleteUser(String userId);
}
