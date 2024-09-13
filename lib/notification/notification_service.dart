import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/constants/app_export.dart';
import '../core/routes/app_routes.dart';

var deviceToken;
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
}

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
    playSound: true,
  );

  final localNotification = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initConnectivity();
  }

  // Firebase Push Notification
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // Handle the message, e.g., navigate to a specific screen
  }

  Future<void> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final data = message.data;
      print("Title: ${notification?.title}");
      print("Body: ${notification?.body}");
      print("Payload: $data");
      final android = message.notification?.android;
      if (notification != null && android != null) {
        localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
             
              channel.id,
              channel.name,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
  }

  Future<void> initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          // Navigate to specific screen based on payload
          Get.toNamed(AppRoutes.NOTIFICATION);
        }
      },
    );

    final platform = localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(channel);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    // final fCMToken = await _firebaseMessaging.getToken();
    // final installationId = await FirebaseInstallations.instance.getId();
    // print('Firbase installaion id: $installationId');
    // print('FCM Token: $fCMToken');
    // deviceToken = fCMToken;
    // await initLocalNotification();
    // await initPushNotification();
  }

  void _initConnectivity() {
    print("object");
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showNoInternetNotification();
      }
    });
  }

  Future<void> _showNoInternetNotification() async {
    await localNotification.show(
      0,
      'Internet Disconnected',
      'You are not connected to the internet',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'no_internet_channel',
          'No Internet',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}
