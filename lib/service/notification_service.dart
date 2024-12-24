import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
}

class NotificationService {
  static final NotificationService _singleton = NotificationService._internal();

  factory NotificationService() => _singleton;

  NotificationService._internal();

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isFlutterLocalNotificationsInitialized = false;

  late final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  instance() async {
    await _init();
    await _setupLocalNotification();
  }

  Future<void> _init() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageListen);
    FirebaseMessaging.onMessageOpenedApp.listen(
      _onMessageOpenedApp,
      onError: (error) {
        log(error.toString());
      },
    );
  }

  Future<void> _setupLocalNotification() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('icon_noti');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  _onMessageListen(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null && !kIsWeb) {
      String payload = json.encode(message.data);

      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'icon_noti',
          ),
        ),
        payload: payload,
      );
    }
  }

  Future<RemoteMessage?> getInitMessage() async {
    return await _firebaseMessaging.getInitialMessage();
  }

  void _onMessageOpenedApp(RemoteMessage message) async {
    await onClickedNotification(message, false);
  }

  Future<void> onClickedNotification(
      RemoteMessage message, bool initBuildApp) async {}
}
