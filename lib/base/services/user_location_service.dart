import '../models/userLocation/user_location.dart';
import 'base/base_service.dart';
import 'interfaces/iuser_location_service.dart';

class UserLocationService extends BaseService implements IUserLocationService {
  @override
  Future<bool> createOrUpdateUserLocation(UserLocation userLocation) async {
    try {
      final url = '${baseUrlApi}UserLocation/CreateUpdateUserLocationDto';
      final response = await super.post(url, userLocation.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<UserLocation?> getUserLocation() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}UserLocation/GetUserLocation';
      final response = await super.get(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return UserLocation.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteUserLocation() async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}UserLocation/DeleteUserLocation';
      final response = await super.delete(url, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }
}