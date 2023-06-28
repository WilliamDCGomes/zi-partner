import 'package:carousel_slider/carousel_controller.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/gym/gym.dart';
import 'package:zi_partner/base/models/message/message.dart';
import '../../../app/enums/enums.dart';
import '../userPictures/user_pictures.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  late String name;
  late String userName;
  @JsonKey(includeFromJson: false)
  late String initialsName;
  late String aboutMe;
  late Messages? lastMessage;
  late String? longitude;
  late String? latitude;
  late double distance;
  late List<Gym>? gyms;
  late List<UserPictures>? picture;
  late TypeGender gender;

  @JsonKey(includeFromJson: false)
  late CarouselController carouselController;

  Person({
    required this.name,
    required this.userName,
    required this.aboutMe,
    required this.longitude,
    required this.latitude,
    required this.distance,
    required this.gyms,
    required this.picture,
    required this.gender,
    this.lastMessage,
  }){
    carouselController = CarouselController();

    var names = name.trim().split(" ");

    if(names.isNotEmpty && names.first != ""){
      initialsName = names.first[0];
      if(names.length > 1 && names.last != ""){
        initialsName += names.last[0];
      }
    }
    else{
      initialsName = "NI";
    }
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}