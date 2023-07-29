import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  late bool success;
  late String userId;
  late String? errorMessage;
  late String? errorCode;

  ForgetPasswordResponse({
    required this.success,
    required this.userId,
    this.errorMessage,
    this.errorCode,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}