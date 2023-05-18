import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/base/zi_partner_core.dart';

part 'match_or_dislike.g.dart';

@JsonSerializable()
class MatchOrDislike extends ZiPartnerCore {
  late String userId;
  late String otherUserId;
  late bool isMatch;

  MatchOrDislike({
    required this.userId,
    required this.otherUserId,
    required this.isMatch,
  });

  factory MatchOrDislike.fromJson(Map<String, dynamic> json) => _$MatchOrDislikeFromJson(json);

  Map<String, dynamic> toJson() => _$MatchOrDislikeToJson(this);
}