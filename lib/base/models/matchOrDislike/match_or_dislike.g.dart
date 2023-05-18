// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_or_dislike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchOrDislike _$MatchOrDislikeFromJson(Map<String, dynamic> json) =>
    MatchOrDislike(
      userId: json['userId'] as String,
      otherUserId: json['otherUserId'] as String,
      isMatch: json['isMatch'] as bool,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = ZiPartnerCore.fromJsonActive(json['active']);

Map<String, dynamic> _$MatchOrDislikeToJson(MatchOrDislike instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'userId': instance.userId,
      'otherUserId': instance.otherUserId,
      'isMatch': instance.isMatch,
    };
