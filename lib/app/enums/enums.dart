import 'package:json_annotation/json_annotation.dart';

enum Flavor {
  dev,
  hmlg,
  prod,
}

enum ImageOrigin {
  camera,
  gallery,
}

enum DestinationsPages {
  settings,
  fingerPrintSetting,
  resetPassword,
  logout,
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