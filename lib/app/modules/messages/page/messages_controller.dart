import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import '../../../../base/models/message/message.dart';
import '../../../../base/models/person/person.dart';

class MessagesController extends GetxController {
  late Person recipientPerson;
  late RxList<Message> messagesList;
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
    messagesList = <Message>[].obs;
    newMessage = TextEditingController();
    scrollController = ScrollController();
  }

  _getMessages() async {
    messagesList.addAll([
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Oi, tudo bem?",
          messageDate: DateTime.now().add(-const Duration(minutes: 25)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Aonde você treina?",
          messageDate: DateTime.now().add(-const Duration(minutes: 25)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Oi, eu Treino na Smart Fit, e você?",
          messageDate: DateTime.now().add(-const Duration(minutes: 22)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Ah que legal!",
          messageDate: DateTime.now().add(-const Duration(minutes: 20)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Eu treino lá também!",
          messageDate: DateTime.now().add(-const Duration(minutes: 19)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Ah que bom!",
          messageDate: DateTime.now().add(-const Duration(minutes: 16)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Podemos marcar um treino para amanhã as 19:00?",
          messageDate: DateTime.now().add(-const Duration(minutes: 16)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Podemos sim!",
          messageDate: DateTime.now().add(-const Duration(minutes: 12)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "O que você costuma treinar?",
          messageDate: DateTime.now().add(-const Duration(minutes: 11)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Eu treino perna Segunda, peito na Quarta e costas na sexta. E você? Treina diferente disso?",
          messageDate: DateTime.now().add(-const Duration(minutes: 8)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Eu até chego a treinar, mas posso me adaptar a esse treino sem problemas",
          messageDate: DateTime.now().add(-const Duration(minutes: 8)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Ah perfeito, podemos começar com perna amanhã então?",
          messageDate: DateTime.now().add(-const Duration(minutes: 6)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Podemos sim! Sem problemas",
          messageDate: DateTime.now().add(-const Duration(minutes: 5)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Perfeito, então fica combinado para amanhã as 19:00",
          messageDate: DateTime.now().add(-const Duration(minutes: 5)),
        ),
        Message(
          senderId: recipientId,
          recipientId: LoggedUser.id,
          message: "Até lá!",
          messageDate: DateTime.now().add(-const Duration(minutes: 4)),
        ),
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: "Combinado, até lá",
          messageDate: DateTime.now().add(-const Duration(minutes: 2)),
        ),
      ],
    );
  }

  sendMessage() async {
    if(newMessage.text.isNotEmpty) {
      messagesList.add(
        Message(
          senderId: LoggedUser.id,
          recipientId: recipientId,
          message: newMessage.text,
          messageDate: DateTime.now(),
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
