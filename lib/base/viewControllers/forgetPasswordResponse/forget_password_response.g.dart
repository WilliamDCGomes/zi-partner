// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordResponse _$ForgetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordResponse(
      success: json['success'] as bool,
      userId: json['userId'] as String,
      errorMessage: json['errorMessage'] as String?,
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$ForgetPasswordResponseToJson(
        ForgetPasswordResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'userId': instance.userId,
      'errorMessage': instance.errorMessage,
      'errorCode': instance.errorCode,
    };
