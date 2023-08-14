import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/base/zi_partner_core.dart';
import '../../../app/enums/enums.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends ZiPartnerCore {
  late String name;
  late String userName;
  late String aboutMe;
  late String cellphone;
  late String email;
  late String password;
  late String deviceToken;
  late DateTime? birthdayDate;
  late TypeGender gender;

  User({
    required this.name,
    required this.userName,
    required this.aboutMe,
    required this.cellphone,
    required this.email,
    required this.password,
    required this.birthdayDate,
    required this.gender,
    required this.deviceToken,
  });

  User.empty() {
    name = "";
    userName = "";
    aboutMe = "";
    cellphone = "";
    email = "";
    password = "";
    deviceToken = "";
    gender = TypeGender.none;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}