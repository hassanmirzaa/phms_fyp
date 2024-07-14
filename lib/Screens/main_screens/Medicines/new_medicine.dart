import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:phms_fyp/colors/colors.dart';

class MedicationDetail {
  final String name;
  final String description;
  final int dosesPerDay;
  final List<TimeOfDay> times;

  MedicationDetail({
    required this.name,
    required this.description,
    required this.dosesPerDay,
    required this.times,
  });
}

class NewMedicinePage extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const NewMedicinePage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<NewMedicinePage> createState() => _NewMedicinePageState();
}

class _NewMedicinePageState extends State<NewMedicinePage> {
  final _formKey = GlobalKey<FormState>();
  final medicationNameController = TextEditingController();
  final medicationDescriptionController = TextEditingController();
  int dosesPerDay = 1;
  List<TimeOfDay> times = [];

  @override
  void initState() {
    super.initState();
    times = List.generate(dosesPerDay, (index) => TimeOfDay(hour: 0, minute: 0));
  }

  Future<void> _scheduleNotifications(String medicationName) async {
    for (int i = 0; i < times.length; i++) {
      final time = times[i];
      final now = DateTime.now();
      final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
      

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i, // Unique ID for each notification
          channelKey: 'alarm_channel',
          title: 'Medicine Reminder',
          body: medicationName,
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Medication"),
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
                    Text("Medication Name :", style: TextStyle(fontSize: 22)),
                    TextFormField(
                      controller: medicationNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the medication name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text("Description:", style: TextStyle(fontSize: 22)),
                    TextFormField(
                      controller: medicationDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text("Doses Per Day", style: TextStyle(fontSize: 22)),
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
                      Map<String, dynamic> medicationData = {
                        'name': medicationNameController.text.toString(),
                        'description': medicationDescriptionController.text.toString(),
                        'dosesPerDay': dosesPerDay,
                        'times': times.map((time) => '${time.hour}:${time.minute.toString().padLeft(2, '0')}').toList(),
                      };
                      widget.onSubmit(medicationData);
                      await _scheduleNotifications(medicationData['name']);
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
