// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderId: json['senderId'] as String,
      recipientId: json['recipientId'] as String,
      message: json['message'] as String,
      messageDate: DateTime.parse(json['messageDate'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'recipientId': instance.recipientId,
      'message': instance.message,
      'messageDate': instance.messageDate.toIso8601String(),
    };
