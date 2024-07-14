
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/main_screens/Awearness/new_awearness.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AwarenessesScreen extends StatefulWidget {
  const AwarenessesScreen(); // Updated class name

  @override
  State<AwarenessesScreen> createState() => _AwarenessesScreenState(); // Updated class name
}

class _AwarenessesScreenState extends State<AwarenessesScreen> { // Updated class name
  List<Map<String, dynamic>> awarenessDetails = []; // Updated variable name

  @override
  void initState() {
    super.initState();
    loadAwarenessData(); // Updated method call
  }

  loadAwarenessData() async { // Updated method name
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('awarenessDetails')) { // Updated key
      String jsonData = prefs.getString('awarenessDetails')!;
      setState(() {
        awarenessDetails = List<Map<String, dynamic>>.from(
          (json.decode(jsonData) as List<dynamic>)
              .map((item) => Map<String, dynamic>.from(item)),
        );
      });
    }
  }

  saveAwarenessData() async { // Updated method name
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(awarenessDetails);
    prefs.setString('awarenessDetails', jsonData); // Updated key
  }

  void deleteAwareness(int index) { // Updated method name
    setState(() {
      awarenessDetails.removeAt(index);
      saveAwarenessData(); // Updated method call
    });
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: CustomDrawer(currentPage: 'awarenesses'),
      appBar: AppBar(
        title: Text("Awarenesses"), // Updated title
        backgroundColor: AppColor.primaryColor,
      ),
      body: Stack(
        children:[
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: awarenessDetails.length,
                  itemBuilder: (context, index) {
                    final awareness = awarenessDetails[index]; // Updated variable name
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
                              Text("Name: ${awareness['name']}", // Updated text
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold,color: AppColor.textWhiteColor)),
                              SizedBox(height: 8),
                              Text("Description: ${awareness['description']}", // Updated text
                                  style: TextStyle(fontSize: 18,color: AppColor.textWhiteColor)),
                              
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () => deleteAwareness(index), // Updated function call
                                  icon: Icon(Icons.delete,color: AppColor.textWhiteColor,),
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
                        builder: (context) => NewAwarenessPage( // Updated route
                          onSubmit: (awarenessData) {
                            setState(() {
                              awarenessDetails.add(awarenessData); // Updated variable name
                              saveAwarenessData(); // Updated method call
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
                                )
                              ],
                            ),
                    child: Center(
                      child: Text("Add Awareness", // Updated text
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: Height * 0.05),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
