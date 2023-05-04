import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/models/message/message.dart';
import '../../../../base/models/person/person.dart';

class MessagesController extends GetxController {
  late Person recipientPerson;
  late RxList<Message> messagesList;
  late TextEditingController newMessage;

  MessagesController(this.recipientPerson) {
    _initializeVariables();
  }

  _initializeVariables() {
    messagesList = <Message>[].obs;
    newMessage = TextEditingController();
  }
}
