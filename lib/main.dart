import 'package:flutter/material.dart';
import 'package:bayt_aura/bayt_aura_app.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/core/networking/local_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  setUpGetIt();
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // app icon

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await LocalNotificationService.init();
  runApp(const BaytAura());
}
