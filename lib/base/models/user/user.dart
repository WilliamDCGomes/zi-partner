import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/base/zi_partner_core.dart';
import '../../../app/enums/enums.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends ZiPartnerCore {
  late String name;
  String? tellphone;
  DateTime? birthdayDate;
  String? document;
  late TypeGender gender;
  String? cep;
  String? uf;
  String? city;
  String? address;
  String? number;
  String? district;
  String? complement;
  String? cellphone;
  String? email;
  late String userName;
  String? password;

  User({
    required this.name,
    required this.tellphone,
    required this.document,
    required this.userName,
    required this.password,
  });

  User.empty() {
    name = "";
    tellphone = "";
    document = "";
    userName = "";
    password = "";
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}