import 'package:json_annotation/json_annotation.dart';

part 'address_information.g.dart';

@JsonSerializable()
class AddressInformation {
  late String uf;
  late String localidade;
  late String logradouro;
  late String bairro;
  late String complemento;

  AddressInformation({
    required this.uf,
    required this.localidade,
    required this.logradouro,
    required this.bairro,
    required this.complemento,
  });

  factory AddressInformation.fromJson(Map<String, dynamic> json) => _$AddressInformationFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInformationToJson(this);
}