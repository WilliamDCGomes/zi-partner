abstract class INotificationsService {
  Future<bool> sendNotification(String playerId, String message);
}
