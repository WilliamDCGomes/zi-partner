import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import '../base/zi_partner_core.dart';

part 'message.g.dart';

@JsonSerializable()
class Messages extends ZiPartnerCore {
  late String userId;
  late String receiverId;
  late String message;
  @JsonKey(includeFromJson: false)
  late bool itsMine;

  Messages({
    required this.userId,
    required this.receiverId,
    required this.message,
    DateTime? internInclusion,
  }){
    itsMine = userId == LoggedUser.id;
    inclusion = internInclusion;
  }

  factory Messages.fromJson(Map<String, dynamic> json) => _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}