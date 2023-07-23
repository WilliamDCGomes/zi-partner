import '../models/userGym/user_gym.dart';
import 'base/base_service.dart';
import 'interfaces/iuser_gym_service.dart';

class UserGymService extends BaseService implements IUserGymService {
  @override
  Future<bool> createUserGym(UserGym userGym) async {
    try {
      final url = '${baseUrlApi}UserGym/CreateUserGym';
      final response = await super.post(url, userGym.toJson());
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body as bool;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> checkIfGymExistByName(String gymId) async {
    try {
      final url = '${baseUrlApi}UserGym/CheckIfUserGymExist';
      final response = await super.get(url, query: {"GymId": gymId});
      if (hasErrorResponse(response)) throw Exception();
      return response.body as bool;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteUserGym(String userId, String gymId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}UserGym/DeleteUserGym';
      final response = await super.delete(url, query: {"UserId": userId, "GymId": gymId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body as bool;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllUserGymFromUser() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}UserGym/DeleteAllUserGymFromUser';
      final response = await super.delete(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body as bool;
    } catch (_) {
      return false;
    }
  }
}