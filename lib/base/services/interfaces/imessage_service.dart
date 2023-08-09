import 'package:zi_partner/base/models/message/message.dart';

abstract class IMessageService {
  Future<bool> createMessage(Messages message);

  Future<bool> updateMessage(Messages message);

  Future<bool> setMessageAsRead(Messages message);

  Future<List<Messages>?> getAllMessages(String receiverId);

  Future<List<Messages>?> getNext15Messages(String receiverId, int skip);

  Future<List<Messages>?> getNewMessages(String receiverId);

  Future<Messages?> getLastNewMessages(String receiverId);

  Future<DateTime> getDateTimeToNewMessage();

  Future<bool> deleteMessage(String messageId);
}
