import 'package:flutter/material.dart';
import 'package:bayt_aura/bayt_aura_app.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/core/networking/local_notification_service.dart';

void main() async {
  setUpGetIt();
  await LocalNotificationService.init();
  runApp(const BaytAura());
}
