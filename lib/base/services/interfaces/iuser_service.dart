import '../../models/person/person.dart';
import '../../models/user/user.dart';
import '../../models/userPictures/user_pictures.dart';
import '../../viewControllers/authenticateResponse/authenticate_response.dart';
import '../../viewControllers/forgetPasswordResponse/forget_password_response.dart';

abstract class IUserService {
  Future<AuthenticateResponse?> authenticate({String? username, String? password});

  Future<bool> createUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> updateDeviceToken(String deviceToken);

  Future<bool> checkUserNameAlreadyRegistered(String userName);

  Future<bool> checkCellphoneAlreadyRegistered(String cellphone);

  Future<bool> checkEmailAlreadyRegistered(String email);

  Future<Person?> getUserInformation(String userName);

  Future<UserPictures?> getUserProfilePicture();

  Future<List<Person>?> getNextFiveUsers(int skip);

  Future<ForgetPasswordResponse?> validationForgetPasswordCode(String userEmail, String code);

  Future<ForgetPasswordResponse?> forgetPassword(String userEmail);

  Future<bool> forgetPasswordWithId(String userId, String password);

  Future<bool> forgetPasswordInternal(String password);

  Future<bool> deleteUser();
}
