import 'package:json_annotation/json_annotation.dart';
import '../base/zi_partner_core.dart';

part 'user_pictures.g.dart';

@JsonSerializable()
class UserPictures extends ZiPartnerCore {
  late String userId;
  late bool mainPicture;
  late String base64;

  UserPictures({
    required this.userId,
    required this.mainPicture,
    required this.base64,
  });

  factory UserPictures.fromJson(Map<String, dynamic> json) => _$UserPicturesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPicturesToJson(this);
}