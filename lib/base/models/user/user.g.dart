// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      userName: json['userName'] as String,
      aboutMe: json['aboutMe'] as String,
      cellphone: json['cellphone'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      birthdayDate: json['birthdayDate'] == null
          ? null
          : DateTime.parse(json['birthdayDate'] as String),
      gender: $enumDecode(_$TypeGenderEnumMap, json['gender']),
      deviceToken: json['deviceToken'] as String,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = ZiPartnerCore.fromJsonActive(json['active']);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'name': instance.name,
      'userName': instance.userName,
      'aboutMe': instance.aboutMe,
      'cellphone': instance.cellphone,
      'email': instance.email,
      'password': instance.password,
      'deviceToken': instance.deviceToken,
      'birthdayDate': instance.birthdayDate?.toIso8601String(),
      'gender': _$TypeGenderEnumMap[instance.gender]!,
    };

const _$TypeGenderEnumMap = {
  TypeGender.masculine: 0,
  TypeGender.feminine: 1,
  TypeGender.none: 2,
};
