import 'package:json_annotation/json_annotation.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import '../base/zi_partner_core.dart';

part 'message.g.dart';

@JsonSerializable()
class Messages extends ZiPartnerCore {
  late String userId;
  late String receiverId;
  late String message;
  late bool read;
  @JsonKey(includeFromJson: false)
  late bool itsMine;
  @JsonKey(includeFromJson: false)
  late String messageDate;

  Messages({
    required this.userId,
    required this.receiverId,
    required this.message,
    required this.read,
    super.inclusion,
    super.alteration,
  }){
    itsMine = userId == LoggedUser.id;
    setMessageDate();
  }

  setMessageDate() {
    String day = "";
    String month = "";
    if(inclusion != null) {
      if(inclusion!.day < 10) {
        day = "0${inclusion!.day}";
      } else {
        day = inclusion!.day.toString();
      }
      if(inclusion!.month < 10) {
        month = "0${inclusion!.month}";
      } else {
        month = inclusion!.month.toString();
      }
    }

    messageDate = "$day/$month/${inclusion?.year}";
  }

  factory Messages.fromJson(Map<String, dynamic> json) => _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}