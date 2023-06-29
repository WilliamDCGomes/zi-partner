import 'package:geolocator/geolocator.dart';
import '../../../base/models/userLocation/user_location.dart';
import '../../../base/services/interfaces/iuser_location_service.dart';
import '../../../base/services/user_location_service.dart';

class SendLocation {
  static Future<void> sendUserLocation(String userId) async {
    try {
      final IUserLocationService userLocationService = UserLocationService();
      final currentLocation = await _determinePosition();

      if (currentLocation == null) return;

      final userLocation = UserLocation(
        longitude: currentLocation.longitude.toString(),
        latitude: currentLocation.latitude.toString(),
        userId: userId,
      );

      await userLocationService.createOrUpdateUserLocation(userLocation);
    }
    catch(_) {

    }
  }

  static Future<Position?> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }
}
