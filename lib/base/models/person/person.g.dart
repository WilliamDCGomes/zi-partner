// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      userName: json['userName'] as String,
      aboutMe: json['aboutMe'] as String,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      gyms: (json['gyms'] as List<dynamic>?)
          ?.map((e) => Gym.fromJson(e as Map<String, dynamic>))
          .toList(),
      picture: (json['picture'] as List<dynamic>?)
          ?.map((e) => UserPictures.fromJson(e as Map<String, dynamic>))
          .toList(),
      gender: $enumDecode(_$TypeGenderEnumMap, json['gender']),
      birthdayDate: DateTime.parse(json['birthdayDate'] as String),
      lastMessage: json['lastMessage'] == null
          ? null
          : Messages.fromJson(json['lastMessage'] as Map<String, dynamic>),
      cellphone: json['cellphone'] as String?,
      email: json['email'] as String?,
    )
      ..id = json['id'] as String
      ..playerId = json['playerId'] as String;

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'name': instance.name,
      'userName': instance.userName,
      'aboutMe': instance.aboutMe,
      'lastMessage': instance.lastMessage,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'birthdayDate': instance.birthdayDate.toIso8601String(),
      'cellphone': instance.cellphone,
      'email': instance.email,
      'distance': instance.distance,
      'gyms': instance.gyms,
      'picture': instance.picture,
      'gender': _$TypeGenderEnumMap[instance.gender]!,
    };

const _$TypeGenderEnumMap = {
  TypeGender.masculine: 0,
  TypeGender.feminine: 1,
  TypeGender.none: 2,
};
