import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  late String senderId;
  late String recipientId;
  late String message;
  late DateTime messageDate;
  @JsonKey(includeFromJson: false)
  late bool itsMine;

  Message({
    required this.senderId,
    required this.recipientId,
    required this.message,
    required this.messageDate,
  }){
    itsMine = senderId == LoggedUser.id;
  }

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}