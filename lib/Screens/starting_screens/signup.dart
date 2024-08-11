import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/starting_screens/dashboard.dart.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? dropdownValue;
  String? bloodGroupValue;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final ageController = TextEditingController();
  final descriptionController = TextEditingController();
  final diseasesController = TextEditingController();  // New controller for Diseases

  @override
  Widget build(BuildContext context) {
    // final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //heading
              Text(
                "Patient's Details",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Height * 0.02,
              ),

              Form(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [

                      //First Name
                      TextFormField(
                        controller: firstnameController,
                        //autofocus: true,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,

                        decoration: InputDecoration(
                          label: const Text('First Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Height * 0.02,
                      ),

                      //Last Name
                      TextFormField(
                        controller: lastnameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          label: const Text('Last Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Height * 0.02,
                      ),

                      //Age
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: const Text('Age'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Height * 0.02,
                      ),
                      
                       Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //Gender
                                const Text(
                                  'Gender:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        "Select",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: dropdownValue,
                                      style: TextStyle(color: Colors.black),
                                      icon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Male"),
                                          value: "Male",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Female"),
                                          value: "Female",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("Other"),
                                          value: "Other",
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 16),
                          //blood group
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Blood Group:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 8),
                                InputDecorator(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text(
                                        "Select",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: bloodGroupValue,
                                      style: TextStyle(color: Colors.black),
                                      icon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("A+"),
                                          value: "A+",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("A-"),
                                          value: "A-",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("B+"),
                                          value: "B+",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("B-"),
                                          value: "B-",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("AB+"),
                                          value: "AB+",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("AB-"),
                                          value: "AB-",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("O+"),
                                          value: "O+",
                                        ),
                                        DropdownMenuItem(
                                          child: Text("O-"),
                                          value: "O-",
                                        ),
                                      ],
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            bloodGroupValue = newValue;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Height * 0.04,
                      ),

                      //Description
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          label: const Text('Description'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Height * 0.02,
                      ),

                      // Diseases
                      TextFormField(
                        controller: diseasesController,  // New Diseases field
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          label: const Text('Diseases'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: () async {
                  if (_validateFields()) {
                    // All fields are filled, proceed with submission
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setString('name', firstnameController.text);
                    sp.setString('lastName', lastnameController.text);
                    sp.setString("age", ageController.text);
                    sp.setString("gender", dropdownValue!);
                    sp.setString("blood", bloodGroupValue!);
                    sp.setString("description", descriptionController.text);
                    sp.setString("diseases", diseasesController.text);  // Save Diseases field value
                    sp.setBool("isLogin", true);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DahsboardScreen(),
                      ),
                    );
                  } else {
                    // Show Snackbar indicating fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill out all fields.'),
                        backgroundColor: AppColor.primaryColor,
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
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
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> infoo() async {}

  bool _validateFields() {
    // Check if any controller is empty
    return firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        dropdownValue != null &&
        bloodGroupValue != null &&
        descriptionController.text.isNotEmpty &&
        diseasesController.text.isNotEmpty;  // Include Diseases field in validation
  }
}
