import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phms_fyp/Screens/starting_screens/splashScreen.dart';
import 'package:phms_fyp/colors/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    null, // Make sure this path points to your app icon
    [
      NotificationChannel(
        channelKey: 'alarm_channel',
        channelName: 'Alarm notifications',
        channelDescription: 'Notification channel for alarms',
        defaultColor: Color(0xFF9D50DD), // Ensure this is a valid color
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        playSound: true,
        enableVibration: true,
        locked: true,
        criticalAlerts: true,
      )
    ],
  );

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: AppColor.primaryColor,
          titleTextStyle: GoogleFonts.outfit(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
