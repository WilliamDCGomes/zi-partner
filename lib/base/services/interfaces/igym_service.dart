import 'package:zi_partner/base/models/gym/gym.dart';

abstract class IGymService {
  Future<bool> createGym(Gym gym);

  Future<bool> updateGym(Gym gym);

  Future<List<Gym>?> getGymsByName(String gymName);

  Future<List<Gym>?> get10FirstGyms();
}
