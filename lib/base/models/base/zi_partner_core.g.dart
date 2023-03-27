// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zi_partner_core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZiPartnerCore _$ZiPartnerCoreFromJson(Map<String, dynamic> json) =>
    ZiPartnerCore(
      id: json['id'] as String?,
      inclusion: json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String),
      alteration: json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String),
      active: ZiPartnerCore.fromJsonActive(json['active']),
    );

Map<String, dynamic> _$ZiPartnerCoreToJson(ZiPartnerCore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
    };
