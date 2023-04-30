import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showWelcomeNotification() async {
    const String title = 'Welcome to DevModelAI';
    const String message =  
        'We\'re excited to have you on board! Let us help you choose the most suitable development model for your software projects and take the guesswork out of the equation.';

    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'welcome_notification',
      'Welcome Notification',
      channelDescription: 'Welcome notification for new users',
      importance: Importance.max,
      priority: Priority.high,
      color: Color(0xfffbc108),
      styleInformation: BigTextStyleInformation(message),
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      notificationDetails,
    );
  }
}
