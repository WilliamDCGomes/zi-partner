import 'base/base_service.dart';
import 'interfaces/inotifications_service.dart';

class NotificationsService extends BaseService implements INotificationsService {
  @override
  Future<bool> sendNotification(String playerId, String message) async {
    try {
      final token = await getToken();
      final url = '${baseUrlApi}Notifications/SendNotification';
      final response = await super.post(url, {"PlayerId": "d8bb10f3-780e-424e-b050-c788c6e1838e", "Message": message}, headers: {"Authorization": 'Bearer $token'});
      if (hasErrorResponse(response) || response.body is! bool) throw Exception();
      return response.body as bool;
    } catch (_) {
      return false;
    }
  }
}