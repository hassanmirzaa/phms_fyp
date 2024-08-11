import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:phms_fyp/colors/colors.dart';

class TaskDetail {
  final String name;
  final String description;
  final int dosesPerDay;
  final List<TimeOfDay> times;

  TaskDetail({
    required this.name,
    required this.description,
    required this.dosesPerDay,
    required this.times,
  });
}

class NewTaskPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const NewTaskPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  int dosesPerDay = 1;
  List<TimeOfDay> times = [];

  @override
  void initState() {
    super.initState();
    times = List.generate(dosesPerDay, (index) => TimeOfDay(hour: 0, minute: 0));
    _requestNotificationPermissions();
  }

  Future<void> _scheduleNotifications(String taskName, List<TimeOfDay> times) async {
    for (int i = 0; i < times.length; i++) {
      final time = times[i];
      final now = DateTime.now();
      final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000), // Unique ID for each notification
          channelKey: 'alarm_channel',
          title: 'Task Reminder',
          body: taskName,
          notificationLayout: NotificationLayout.Default,
          fullScreenIntent: true, // This makes the notification full-screen
          autoDismissible: false, // Ensures user interaction is required
        ),
        schedule: NotificationCalendar(
          year: scheduledTime.year,
          month: scheduledTime.month,
          day: scheduledTime.day,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          millisecond: 0,
          repeats: false, // Set to true if you want the notification to repeat daily
        ),
      );
    }
  }

  Future<void> _requestNotificationPermissions() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Name :", style: TextStyle(fontSize: 22)),
                    TextFormField(
                      controller: taskNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text("Description:", style: TextStyle(fontSize: 22)),
                    TextFormField(
                      controller: taskDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    const Text("Doses Per Day", style: TextStyle(fontSize: 22)),
                    DropdownButton<int>(
                      value: dosesPerDay,
                      items: List.generate(48, (index) => index + 1)
                          .map<DropdownMenuItem<int>>(
                            (int value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          dosesPerDay = newValue!;
                          times = List.generate(newValue, (index) => TimeOfDay(hour: 0, minute: 0));
                        });
                      },
                    ),
                    Column(
                      children: List.generate(
                        dosesPerDay,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: InkWell(
                            onTap: () => _selectTime(index),
                            child: Container(
                              width: width * 0.2,
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Time ${index + 1}',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Text(
                                  '${times[index].hour}:${times[index].minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.13),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> taskData = {
                        'name': taskNameController.text.toString(),
                        'description': taskDescriptionController.text.toString(),
                        'dosesPerDay': dosesPerDay,
                        'times': times.map((time) => '${time.hour}:${time.minute.toString().padLeft(2, '0')}').toList(),
                      };
                      widget.onSubmit(taskData);
                      await _scheduleNotifications(taskData['name'], times);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task added successfully!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: height * 0.085,
                    width: width * 0.35,
                    child: Center(
                      child: Text("Submit", style: TextStyle(fontSize: 18, color: AppColor.textWhiteColor)),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(16)),
                      boxShadow: [BoxShadow(offset: Offset(-4, 2), blurRadius: 10)],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(int index) async {
    TimeOfDay initialTime = times[index];
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null && picked != initialTime) {
      setState(() {
        times[index] = picked;
      });
    }
  }
}
