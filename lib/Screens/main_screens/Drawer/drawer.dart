import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/Sign%20out/signout.dart';
import 'package:phms_fyp/Screens/main_screens/Awearness/awearness.dart';
import 'package:phms_fyp/Screens/main_screens/Health%20Monitoring/health_monitoring.dart';
import 'package:phms_fyp/Screens/main_screens/Medicines/medicines.dart';
import 'package:phms_fyp/Screens/main_screens/Reports/reports.dart';
import 'package:phms_fyp/Screens/main_screens/Tasks/tasks.dart';
import 'package:phms_fyp/Screens/starting_screens/dashboard.dart.dart';
import 'package:phms_fyp/colors/colors.dart';

class CustomDrawer extends StatelessWidget {
  final String currentPage;

  const CustomDrawer({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: Height * 0.07,
          ),
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/images/phms.logo.png'),
            backgroundColor: Colors
                .transparent, // Optional: Set background color to transparent
            // You can also add child widget if needed
          ),
          SizedBox(
            height: Height * 0.02,
          ),
          Divider(
            endIndent: Width * 0.1,
            indent: Width * 0.1,
            color: AppColor.textWhiteColor,
          ),
          ListTile(
            title: Text(
              "Patient's Dashboard",
              style: TextStyle(
                color: /* currentPage == 'dashboard'
                    ? AppColor.primaryColor
                    :*/
                    AppColor.textWhiteColor,
              ),
            ),
            onTap: () {
              if (currentPage != 'dashboard') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DahsboardScreen()),
                );
              }
            },
          ),
          ListTile(
            title: Text(
              'Health Monitoring',
              style: TextStyle(
                color: /*currentPage == 'health_monitoring'
                    ? AppColor.primaryColor
                    :*/
                    AppColor.textWhiteColor,
              ),
            ),
            onTap: () {
              if (currentPage != 'health_monitoring') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HealthMonitoringScreen()),
                );
              }
            },
          ),
          ListTile(
            title: Text(
              'Medications',
              style: TextStyle(
                color: /* currentPage == 'medications'
                    ? AppColor.primaryColor
                    : */
                    AppColor.textWhiteColor,
              ),
            ),
            onTap: () {
              if (currentPage != 'medications') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MedicationsScreen()),
                );
              }
            },
          ),
          ListTile(
            title: Text(
              'Tasks',
              style: TextStyle(
                color: /*currentPage == 'tasks'
                    ? AppColor.primaryColor
                    :*/
                    AppColor.textWhiteColor,
              ),
            ),
            onTap: () {
              if (currentPage != 'tasks') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TasksScreen()),
                );
              }
            },
          ),
          ListTile(
            title: Text(
              'Awarenesses',
              style: TextStyle(
                color: /*currentPage == 'awarenesses'
                    ? AppColor.primaryColor
                    : */
                    AppColor.textWhiteColor,
              ),
            ),
            onTap: () {
              if (currentPage != 'awarenesses') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AwarenessesScreen()),
                );
              }
            },
          ),
          ListTile(
            title: Text(
              'Reports',
              style: TextStyle(
                color: /*currentPage == 'reports'
                    ? AppColor.primaryColor
                    : */
                    AppColor.textWhiteColor,
              ),
            ),
            onTap: () {
              if (currentPage != 'reports') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportsScreen()),
                );
              }
            },
          ),
          const Spacer(),
          ListTile(
            title: Text(
              ' Switch Patient',
              style: TextStyle(color: AppColor.textWhiteColor),
            ),
            onTap: () {
              showSignoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
