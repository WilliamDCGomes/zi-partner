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
      return response.body;
    } catch (_) {
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
      return response.body;
    } catch (_) {
      return false;
    }
  }
}