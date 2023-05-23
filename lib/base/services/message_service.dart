import '../models/message/message.dart';
import 'base/base_service.dart';
import 'interfaces/imessage_service.dart';

class MessageService extends BaseService implements IMessageService {
  @override
  Future<bool> createMessage(Messages message) async {
    try {
      final url = '${baseUrlApi}Message/CreateMessage';
      final response = await super.post(url, message.toJson());
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateMessage(Messages message) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/UpdateMessage';
      final response = await super.put(url, message.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Messages>?> getAllMessages(String userId, String receiverId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/GetAllMessages';
      final response = await super.get(url, query: {"UserId": userId, "ReceiverId": receiverId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Messages.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    try {
      final url = '${baseUrlApi}Message/DeleteMessage';
      final response = await super.delete(url, query: {"MessageId": messageId});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }
}