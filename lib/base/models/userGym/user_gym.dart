import 'package:json_annotation/json_annotation.dart';
import '../base/zi_partner_core.dart';

part 'user_gym.g.dart';

@JsonSerializable()
class UserGym extends ZiPartnerCore {
  late String userId;
  late String gymId;

  UserGym({
    required this.userId,
    required this.gymId,
  });

  factory UserGym.fromJson(Map<String, dynamic> json) => _$UserGymFromJson(json);

  Map<String, dynamic> toJson() => _$UserGymToJson(this);
}