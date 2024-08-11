import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/Screens/main_screens/Tasks/new_task.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen();

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> taskDetails = [];

  @override
  void initState() {
    super.initState();
    loadTaskData();
  }

  loadTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('taskDetails')) {
      String jsonData = prefs.getString('taskDetails')!;
      setState(() {
        taskDetails = List<Map<String, dynamic>>.from(
          (json.decode(jsonData) as List<dynamic>)
              .map((item) => Map<String, dynamic>.from(item)),
        );
      });
    }
  }

  saveTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(taskDetails);
    prefs.setString('taskDetails', jsonData);
  }

  void deleteTask(int index) {
    setState(() {
      taskDetails.removeAt(index);
      saveTaskData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task Deleted!'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: CustomDrawer(currentPage: 'tasks'),
      appBar: AppBar(
        title: Text("Tasks"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: taskDetails.length,
                  itemBuilder: (context, index) {
                    final task = taskDetails[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${task['name']}",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.textWhiteColor)),
                              SizedBox(height: 8),
                              Text("Description: ${task['description']}",
                                  style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor)),
                              SizedBox(height: 8),
                              Text("Doses Per Day: ${task['dosesPerDay']}",
                                  style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor)),
                              SizedBox(height: 8),
                              Text("Times: ",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textWhiteColor)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (task['times'] as List<dynamic>)
                                    .map((time) {
                                  return Text(time, style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor));
                                }).toList(),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () => deleteTask(index),
                                  icon: Icon(Icons.delete, color: AppColor.textWhiteColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Height * 0.13),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewTaskPage(
                          onSubmit: (taskData) {
                            setState(() {
                              taskDetails.add(taskData);
                              saveTaskData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Task Added!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: Height * 0.08,
                    width: Width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-4, 2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text("Add Task", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: Height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
