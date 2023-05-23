import 'package:zi_partner/base/models/gym/gym.dart';

abstract class IGymService {
  Future<bool> createGym(Gym gym);

  Future<bool> updateGym(Gym gym);

  Future<Gym?> getGym(String gymName);
}
