import 'package:carousel_slider/carousel_controller.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../app/enums/enums.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  late String name;
  late String userName;
  late String longitude;
  late String latitude;
  late double distance;
  late List<String> gyms;
  late List<String>? picture;
  late TypeGender gender;

  @JsonKey(ignore: true)
  late CarouselController carouselController;

  Person({
    required this.name,
    required this.userName,
    required this.longitude,
    required this.latitude,
    required this.distance,
    required this.gyms,
    required this.picture,
    required this.gender,
  }){
    carouselController = CarouselController();
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}