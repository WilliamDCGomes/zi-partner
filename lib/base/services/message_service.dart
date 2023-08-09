import '../models/message/message.dart';
import 'base/base_service.dart';
import 'interfaces/imessage_service.dart';

class MessageService extends BaseService implements IMessageService {
  @override
  Future<bool> createMessage(Messages message) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/CreateMessage';
      final response = await super.post(url, message.toJson(), headers: {"Authorization": 'Bearer $token'});
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
  Future<bool> setMessageAsRead(Messages message) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/SetMessageAsRead';
      final response = await super.put(url, message.toJson(), headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return response.body != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Messages>?> getAllMessages(String receiverId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/GetAllMessages';
      final response = await super.get(url, query: {"ReceiverId": receiverId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Messages.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Messages>?> getNext15Messages(String receiverId, int skip) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/GetNext15Messages';
      final response = await super.get(url, query: {"ReceiverId": receiverId, "Skip": skip.toString()}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Messages.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Messages>?> getNewMessages(String receiverId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/GetNewMessages';
      final response = await super.get(url, query: {"ReceiverId": receiverId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return (response.body as List).map((e) => Messages.fromJson(e)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Messages?> getLastNewMessages(String receiverId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/GetLastNewMessages';
      final response = await super.get(url, query: {"ReceiverId": receiverId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response)) throw Exception();
      return Messages.fromJson(response.body);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> deleteMessage(String messageId) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Message/DeleteMessage';
      final response = await super.delete(url, query: {"MessageId": messageId}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body;
    } catch (_) {
      return false;
    }
  }
}