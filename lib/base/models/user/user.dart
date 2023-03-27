import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/base/zi_partner_core.dart';

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
  int? code;
  int? balanceStuffedAnimals;
  DateTime? stuffedAnimalsLastUpdate;
  DateTime? pouchLastUpdate;
  int? balanceMoney;
  late String userName;
  String? password;

  @JsonKey(ignore: true)
  late bool selected;

  User({
    required this.name,
    required this.tellphone,
    required this.document,
    required this.balanceMoney,
    required this.balanceStuffedAnimals,
    required this.pouchLastUpdate,
    required this.stuffedAnimalsLastUpdate,
    required this.userName,
    required this.password,
  }) {
    selected = false;
  }

  User.emptyConstructor() {
    name = "";
    tellphone = "";
    document = "";
    balanceMoney = 0;
    balanceStuffedAnimals = 0;
    selected = false;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum TypeGender {
  @JsonValue(0)
  masculine,
  @JsonValue(1)
  feminine,
  @JsonValue(2)
  other,
  @JsonValue(4)
  none,
}