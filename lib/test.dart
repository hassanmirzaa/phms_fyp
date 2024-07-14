import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class TestNotificationPage extends StatefulWidget {
  const TestNotificationPage({super.key});

  @override
  State<TestNotificationPage> createState() => _TestNotificationPageState();
}

class _TestNotificationPageState extends State<TestNotificationPage> {
  triggerNotification(){
    AwesomeNotifications().createNotification(content: NotificationContent(
      id: 10,
     channelKey: 'basic_channel',
     title: 'Simple Notification',
     body: 'Simple Button'
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(onPressed: (){}, icon: Icon(Icons.notification_add_outlined)),
      ),
    );
  }
}