import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import '../../../../base/models/message/message.dart';
import '../../../../base/models/person/person.dart';

class MessagesController extends GetxController {
  late Person recipientPerson;
  late RxList<Messages> messagesList;
  late TextEditingController newMessage;
  late ScrollController scrollController;
  final recipientId = const Uuid().v4();

  MessagesController(this.recipientPerson) {
    _initializeVariables();
  }

  @override
  void onInit() async {
    _getMessages();
    super.onInit();
  }

  _initializeVariables() {
    messagesList = <Messages>[].obs;
    newMessage = TextEditingController();
    scrollController = ScrollController();
  }

  _getMessages() async {
    messagesList.addAll([
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Oi, tudo bem?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 25)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Aonde você treina?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 25)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Oi, eu Treino na Smart Fit, e você?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 22)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Ah que legal!",
          internInclusion: DateTime.now().add(-const Duration(minutes: 20)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Eu treino lá também!",
          internInclusion: DateTime.now().add(-const Duration(minutes: 19)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Ah que bom!",
          internInclusion: DateTime.now().add(-const Duration(minutes: 16)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Podemos marcar um treino para amanhã as 19:00?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 16)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Podemos sim!",
          internInclusion: DateTime.now().add(-const Duration(minutes: 12)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "O que você costuma treinar?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 11)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Eu treino perna Segunda, peito na Quarta e costas na sexta. E você? Treina diferente disso?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 8)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Eu até chego a treinar, mas posso me adaptar a esse treino sem problemas",
          internInclusion: DateTime.now().add(-const Duration(minutes: 8)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Ah perfeito, podemos começar com perna amanhã então?",
          internInclusion: DateTime.now().add(-const Duration(minutes: 6)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Podemos sim! Sem problemas",
          internInclusion: DateTime.now().add(-const Duration(minutes: 5)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Perfeito, então fica combinado para amanhã as 19:00",
          internInclusion: DateTime.now().add(-const Duration(minutes: 5)),
        ),
        Messages(
          userId: recipientId,
          receiverId: LoggedUser.id,
          message: "Até lá!",
          internInclusion: DateTime.now().add(-const Duration(minutes: 4)),
        ),
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: "Combinado, até lá",
          internInclusion: DateTime.now().add(-const Duration(minutes: 2)),
        ),
      ],
    );
  }

  sendMessage() async {
    if(newMessage.text.isNotEmpty) {
      messagesList.add(
        Messages(
          userId: LoggedUser.id,
          receiverId: recipientId,
          message: newMessage.text,
          internInclusion: DateTime.now(),
        ),
      );
      newMessage.clear();

      await Future.delayed(const Duration(milliseconds: 200));
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }
}
