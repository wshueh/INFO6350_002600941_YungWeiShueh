import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseRemoteConfig _remoteConfig;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initRemoteConfig();
  }

  Future<void> _initRemoteConfig() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 1),
    ));

    await _remoteConfig.fetchAndActivate();

    final interval = _remoteConfig.getInt('periodic_local_notification');

    if (interval > 0) {
      _startTimer(interval);
    }
  }

  void _startTimer(int seconds) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: seconds), (_) {
      _showNotification();
    });
  }

  Future<void> _showNotification() async {
    print('Showing notification at ${DateTime.now()}');

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Scheduled Notification'),
          content: const Text('Triggered by Firebase Remote Config'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel_id',
      'Default Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Scheduled Notification',
      'Triggered by Firebase Remote Config',
      platformDetails,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notification will appear every 15 seconds'),
      ),
    );
  }
}
