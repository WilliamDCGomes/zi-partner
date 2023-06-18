import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/base/zi_partner_core.dart';

part 'gym.g.dart';

@JsonSerializable()
class Gym extends ZiPartnerCore {
  late String name;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late bool selected;

  Gym({
    required this.name,
    this.selected = false,
  });

  factory Gym.fromJson(Map<String, dynamic> json) => _$GymFromJson(json);

  Map<String, dynamic> toJson() => _$GymToJson(this);
}