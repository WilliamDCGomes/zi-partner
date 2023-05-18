import 'package:json_annotation/json_annotation.dart';
import '../base/zi_partner_core.dart';

part 'user_location.g.dart';

@JsonSerializable()
class UserLocation extends ZiPartnerCore {
  late String userId;
  late String latitude;
  late String longitude;

  UserLocation({
    required this.userId,
    required this.latitude,
    required this.longitude,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) => _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}