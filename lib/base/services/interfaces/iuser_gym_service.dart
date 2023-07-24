import 'package:zi_partner/base/models/userGym/user_gym.dart';

abstract class IUserGymService {
  Future<bool> createUserGym(UserGym userGym);

  Future<bool> checkIfUserGymExist(String gymId);

  Future<bool> deleteUserGym(String userId, String gymId);

  Future<bool> deleteAllUserGymFromUser();
}
