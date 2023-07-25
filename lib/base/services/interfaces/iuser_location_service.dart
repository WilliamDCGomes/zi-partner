import 'package:zi_partner/base/models/userLocation/user_location.dart';

abstract class IUserLocationService {
  Future<bool> createOrUpdateUserLocation(UserLocation userLocation);

  Future<UserLocation?> getUserLocation();

  Future<bool> deleteUserLocation();
}
