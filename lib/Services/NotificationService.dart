import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) async {
    // Local Notification Initialization
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    _localNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (response) {
      _handleNotificationClick(response.payload, context);
    });

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 🔥 Check if app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(jsonEncode(message.data), context);
      }
    });

    // 📩 Foreground Message Listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Message: ${message.notification?.title}");
      _showNotification(message);
    });

    // 🔗 When user taps notification (background state)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("🔗 Notification Clicked: ${message.notification?.title}");
      _handleNotificationClick(jsonEncode(message.data), context);
    });
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? 'You have a new message',
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  static void _handleNotificationClick(String? payload, BuildContext context) {
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      print("🔍 Click Payload: $data");

      // Example: Navigate to a screen on notification click
      if (data['screen'] == 'chat') {
        Navigator.pushNamed(context, '/chatScreen');
      }
    }
  }

  static Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
