import 'package:bayt_aura/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> showLocalNotification({
  required String title,
  required String body,
}) async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    'request_channel',
    'Request Updates',
    channelDescription: 'Notifies when request status changes',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title,
    body,
    platformDetails,
  );
}
