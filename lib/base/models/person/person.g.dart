// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      userName: json['userName'] as String,
      aboutMe: json['aboutMe'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      distance: (json['distance'] as num).toDouble(),
      gyms: (json['gyms'] as List<dynamic>).map((e) => e as String).toList(),
      picture:
          (json['picture'] as List<dynamic>?)?.map((e) => e as String).toList(),
      gender: $enumDecode(_$TypeGenderEnumMap, json['gender']),
      lastMessage: json['lastMessage'] as String? ?? "",
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'userName': instance.userName,
      'aboutMe': instance.aboutMe,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'lastMessage': instance.lastMessage,
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
