import 'package:zi_partner/base/models/gym/gym.dart';
import 'base/base_service.dart';
import 'interfaces/igym_service.dart';

class GymService extends BaseService implements IGymService {
  @override
  Future<bool> createGym(Gym gym) async {
    try {
      final url = '${baseUrlApi}Gym/CreateGym';
      final response = await super.post(url, gym.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateGym(Gym gym) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Gym/UpdateGym';
      final response = await super.put(url, gym.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Gym?> getGym(String gymName) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Gym/GetGym';
      final response = await super.get(url, query: {"GymName": gymName}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return Gym.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }
}