// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      userId: json['userId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      read: json['read'] as bool,
    )
      ..id = json['id'] as String?
      ..inclusion = json['inclusion'] == null
          ? null
          : DateTime.parse(json['inclusion'] as String)
      ..alteration = json['alteration'] == null
          ? null
          : DateTime.parse(json['alteration'] as String)
      ..active = ZiPartnerCore.fromJsonActive(json['active']);

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'id': instance.id,
      'inclusion': instance.inclusion?.toIso8601String(),
      'alteration': instance.alteration?.toIso8601String(),
      'active': instance.active,
      'userId': instance.userId,
      'receiverId': instance.receiverId,
      'message': instance.message,
      'read': instance.read,
    };
