import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class InactivityWatcher extends StatefulWidget {
  final Widget child;

  const InactivityWatcher({required this.child, Key? key}) : super(key: key);

  @override
  _InactivityWatcherState createState() => _InactivityWatcherState();
}

class _InactivityWatcherState extends State<InactivityWatcher> {
  Timer? _inactivityTimer;
  final Duration _inactivityDuration = Duration(minutes: 2);

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, _showInactivityNotification);
  }

  Future<void> _showInactivityNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'inactivity_channel',
          'Inactivity',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      0,
      'تنبيه',
      'لقد كنت غير نشط لفترة طويلة',
      platformChannelSpecifics,
    );
  }

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(onPointerDown: (_) => _resetTimer(), child: widget.child);
  }
}
