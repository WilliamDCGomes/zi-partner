import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  late String senderId;
  late String recipientId;
  late String message;
  late DateTime messageDate;

  Message({
    required this.senderId,
    required this.recipientId,
    required this.message,
    required this.messageDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}