import 'package:zi_partner/base/models/message/message.dart';

abstract class IMessageService {
  Future<bool> createMessage(Messages message);

  Future<bool> updateMessage(Messages message);

  Future<List<Messages>?> getAllMessages(String userId, String receiverId);

  Future<bool> deleteMessage(String messageId);
}
