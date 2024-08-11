import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/main_screens/Drawer/drawer.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DahsboardScreen extends StatefulWidget {
  const DahsboardScreen({super.key});

  @override
  State<DahsboardScreen> createState() => _DahsboardScreenState();
}

class _DahsboardScreenState extends State<DahsboardScreen> {
  String? name, lastName, age, gender, blood, description, diseases;

  @override
  void initState() {
    
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('name');
    lastName = sp.getString('lastName');
    age = sp.getString('age');
    gender = sp.getString('gender');
    blood = sp.getString('blood');
    description = sp.getString('description');
    diseases = sp.getString('diseases'); // Retrieve Diseases value
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: CustomDrawer(currentPage: 'dashboard'),
      appBar: AppBar(
        title: Text("Patient's Dashboard"),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/1.png',
                ), // Set your asset image here
                fit: BoxFit.cover,
                opacity: 0.18),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(children: [
                    Text(
                      "Name : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      name.toString() + " " + lastName.toString(),
                      style: TextStyle(fontSize: 25),
                    )
                  ]),
                  SizedBox(
                    height: Height * 0.03,
                  ),
                  Wrap(children: [
                    Text(
                      "Age : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      age.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ]),
                  SizedBox(
                    height: Height * 0.03,
                  ),
                  Wrap(children: [
                    Text(
                      "Gender : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      gender.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ]),
                  SizedBox(
                    height: Height * 0.03,
                  ),
                  Wrap(children: [
                    Text(
                      "Blood Group : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      blood.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ]),
                  SizedBox(
                    height: Height * 0.03,
                  ),
                  Wrap(children: [
                    Text(
                      "Description : ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      description.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ]),
                  SizedBox(
                    height: Height * 0.03,
                  ),
                  Wrap(children: [
                    Text(
                      "Diseases : ", // Display Diseases label
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      diseases.toString(), // Display Diseases value
                      style: TextStyle(fontSize: 25),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
