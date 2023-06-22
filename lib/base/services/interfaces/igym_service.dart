import 'package:zi_partner/base/models/gym/gym.dart';

abstract class IGymService {
  Future<bool> createGym(Gym gym);

  Future<bool> updateGym(Gym gym);

  Future<bool> checkIfGymExist(String gymId);

  Future<bool> checkIfGymExistByName(String gymName);

  Future<List<Gym>?> getGymsByName(String gymName);

  Future<List<Gym>?> get10FirstGyms();
}
