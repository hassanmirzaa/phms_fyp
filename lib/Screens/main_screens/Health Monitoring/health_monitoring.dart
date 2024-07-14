import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/colors/colors.dart';

class HealthMonitoringScreen extends StatefulWidget {
  const HealthMonitoringScreen({super.key});

  @override
  State<HealthMonitoringScreen> createState() => _HealthMonitoringScreenState();
}

class _HealthMonitoringScreenState extends State<HealthMonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: CustomDrawer(currentPage: 'health_monitoring'),
      appBar: AppBar(
        title: Text("Health Monitoring"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: Width * 0.6,
            height: Height * 0.1,
            child: Center(
              child: Text(
                "Connect To Hub",
                style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor),
              ),
            ),
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(-4, 2),
                    blurRadius: 10,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
