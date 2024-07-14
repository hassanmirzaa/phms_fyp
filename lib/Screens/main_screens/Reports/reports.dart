import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/colors/colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: CustomDrawer(currentPage: 'reports'),
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: Text("Reports"),
      ),
      //  body: ,
    );
  }
}
