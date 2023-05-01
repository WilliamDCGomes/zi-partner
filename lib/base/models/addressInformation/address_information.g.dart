// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressInformation _$AddressInformationFromJson(Map<String, dynamic> json) =>
    AddressInformation(
      uf: json['uf'] as String,
      localidade: json['localidade'] as String,
      logradouro: json['logradouro'] as String,
      bairro: json['bairro'] as String,
      complemento: json['complemento'] as String,
    );

Map<String, dynamic> _$AddressInformationToJson(AddressInformation instance) =>
    <String, dynamic>{
      'uf': instance.uf,
      'localidade': instance.localidade,
      'logradouro': instance.logradouro,
      'bairro': instance.bairro,
      'complemento': instance.complemento,
    };
