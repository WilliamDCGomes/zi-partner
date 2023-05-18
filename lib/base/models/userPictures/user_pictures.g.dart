// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_pictures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPictures _$UserPicturesFromJson(Map<String, dynamic> json) => UserPictures(
      userId: json['userId'] as String,
      mainPicture: json['mainPicture'] as bool,
      base64: json['base64'] as String,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = ZiPartnerCore.fromJsonActive(json['active']);

Map<String, dynamic> _$UserPicturesToJson(UserPictures instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'userId': instance.userId,
      'mainPicture': instance.mainPicture,
      'base64': instance.base64,
    };
