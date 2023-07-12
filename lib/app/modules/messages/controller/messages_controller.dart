import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';
import '../../../../base/models/message/message.dart';
import '../../../../base/models/person/person.dart';
import '../../../../base/services/interfaces/imessage_service.dart';
import '../../../../base/services/message_service.dart';
import '../../../utils/sharedWidgets/loading_with_success_or_error_widget.dart';

class MessagesController extends GetxController {
  late bool _allMessagesGet;
  late bool _animationInitialized;
  late RxBool sendingMessage;
  late RxList<Messages> messagesList;
  late FocusNode newMessageFocusNode;
  late Person recipientPerson;
  late TextEditingController newMessage;
  late ScrollController scrollController;
  late LoadingWithSuccessOrErrorWidget loadingWithSuccessOrErrorWidget;
  late IMessageService _messageService;

  MessagesController(this.recipientPerson) {
    _initializeVariables();
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await loadingWithSuccessOrErrorWidget.startAnimation();
    await _getNext15Messages();

    if(scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_){
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
    super.onInit();
  }

  _initializeVariables() {
    _allMessagesGet = false;
    _animationInitialized = false;
    sendingMessage = false.obs;
    messagesList = <Messages>[].obs;
    newMessageFocusNode = FocusNode();
    newMessage = TextEditingController();
    newMessageFocusNode.addListener(() async {
      if(newMessageFocusNode.hasFocus) await _moveListScroll();
    });
    scrollController = ScrollController();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        _getNext15Messages();
      }
    });
    loadingWithSuccessOrErrorWidget = LoadingWithSuccessOrErrorWidget();
    _messageService = MessageService();
  }

  _getNext15Messages() async {
    try {
      if(!_allMessagesGet) {
        if(!_animationInitialized) {
          await loadingWithSuccessOrErrorWidget.startAnimation();
          _animationInitialized = true;
        }
        var messages = await _messageService.getNext15Messages(LoggedUser.id, recipientPerson.id, messagesList.length);

        if(messages != null && messages.isNotEmpty) {
          _allMessagesGet = messages.length < 15;
          for(var message in messages) {
            if(!messagesList.any((x) => x.id == message.id)) messagesList.add(message);
          }
        }
        else {
          _allMessagesGet = true;
        }
      }
    }
    catch(_) {}
    finally {
      if(_animationInitialized) {
        _animationInitialized = false;
        await loadingWithSuccessOrErrorWidget.stopAnimation(justLoading: true);
      }
    }
  }

  sendMessage() async {
    try {
      if(newMessage.text.isNotEmpty) {
        var message = Messages(
          userId: LoggedUser.id,
          receiverId: recipientPerson.id,
          message: newMessage.text,
        );

        sendingMessage.value = true;
        if(!await _messageService.createMessage(message)) throw Exception();
        messagesList.add(message);
        newMessage.clear();

        await _moveListScroll();
        sendingMessage.value = false;
      }
    }
    catch(_) {
      sendingMessage.value = false;
    }
  }

  _moveListScroll() async {
    if(scrollController.hasClients) {
      await Future.delayed(const Duration(milliseconds: 200));
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }
}
