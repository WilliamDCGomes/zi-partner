// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_gym.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGym _$UserGymFromJson(Map<String, dynamic> json) => UserGym(
      userId: json['userId'] as String,
      gymId: json['gymId'] as String,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = ZiPartnerCore.fromJsonActive(json['active']);

Map<String, dynamic> _$UserGymToJson(UserGym instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'userId': instance.userId,
      'gymId': instance.gymId,
    };
