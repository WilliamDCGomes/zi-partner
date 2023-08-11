import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zi_partner/app/utils/helpers/platform_type.dart';
import 'package:zi_partner/base/models/loggedUser/logged_user.dart';

class NotificationHelper {
  final firebaseMessaging = FirebaseMessaging.instance;
  final icLauncher = "@drawable/ic_launcher";

  final _androidChannel = const AndroidNotificationChannel(
    'high importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await getDeviceToken();
    initPushNotifications();
    initLocalNotifications();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    if(message.notification != null) {
      String? title = message.notification!.title;
      String? description = message.notification!.body;
      var payload = message.data;

    }
  }

  void handleMessage(RemoteMessage? message) {
    if(message == null) return;

    //Chama a tela de mensagens
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/ic_launcher");

    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        if(payload.payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
          handleMessage(message);
        }
      }
    );

    if(PlatformType.isAndroid()) {
      final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);
    }
    else {
      final platform = _localNotifications.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      //await platform?.createNotificationChannel(_i);
    }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: icLauncher,
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> getDeviceToken() async {
    LoggedUser.deviceToken = await firebaseMessaging.getToken() ?? "";
    Clipboard.setData(ClipboardData(text: LoggedUser.deviceToken));
    print("Inicio do script\n${LoggedUser.deviceToken}\nFim do script");
  }
}
