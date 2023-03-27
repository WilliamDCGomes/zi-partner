// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      tellphone: json['tellphone'] as String?,
      document: json['document'] as String?,
      balanceMoney: json['balanceMoney'] as int?,
      balanceStuffedAnimals: json['balanceStuffedAnimals'] as int?,
      pouchLastUpdate: json['pouchLastUpdate'] == null
          ? null
          : DateTime.parse(json['pouchLastUpdate'] as String),
      stuffedAnimalsLastUpdate: json['stuffedAnimalsLastUpdate'] == null
          ? null
          : DateTime.parse(json['stuffedAnimalsLastUpdate'] as String),
      userName: json['userName'] as String,
      password: json['password'] as String?,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = ZiPartnerCore.fromJsonActive(json['active'])
      ..birthdayDate = json['birthdayDate'] == null
          ? null
          : DateTime.parse(json['birthdayDate'] as String)
      ..gender = $enumDecode(_$TypeGenderEnumMap, json['gender'])
      ..cep = json['cep'] as String?
      ..uf = json['uf'] as String?
      ..city = json['city'] as String?
      ..address = json['address'] as String?
      ..number = json['number'] as String?
      ..district = json['district'] as String?
      ..complement = json['complement'] as String?
      ..cellphone = json['cellphone'] as String?
      ..email = json['email'] as String?
      ..code = json['code'] as int?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'name': instance.name,
      'tellphone': instance.tellphone,
      'birthdayDate': instance.birthdayDate?.toIso8601String(),
      'document': instance.document,
      'gender': _$TypeGenderEnumMap[instance.gender]!,
      'cep': instance.cep,
      'uf': instance.uf,
      'city': instance.city,
      'address': instance.address,
      'number': instance.number,
      'district': instance.district,
      'complement': instance.complement,
      'cellphone': instance.cellphone,
      'email': instance.email,
      'code': instance.code,
      'balanceStuffedAnimals': instance.balanceStuffedAnimals,
      'stuffedAnimalsLastUpdate':
          instance.stuffedAnimalsLastUpdate?.toIso8601String(),
      'pouchLastUpdate': instance.pouchLastUpdate?.toIso8601String(),
      'balanceMoney': instance.balanceMoney,
      'userName': instance.userName,
      'password': instance.password,
    };

const _$TypeGenderEnumMap = {
  TypeGender.masculine: 0,
  TypeGender.feminine: 1,
  TypeGender.other: 2,
  TypeGender.none: 4,
};
