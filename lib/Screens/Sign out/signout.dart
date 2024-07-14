

import 'package:flutter/material.dart';
import 'package:phms_fyp/Screens/starting_screens/signup.dart';
import 'package:phms_fyp/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSignoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      backgroundColor: AppColor.primaryColor,
      title: Text(
        'Do you want to Signout?',
        style: TextStyle(color: AppColor.textWhiteColor),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.22,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColor.textWhiteColor, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "No",
                        style: TextStyle(
                            color: AppColor.textWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.clear();
                    Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => SignUp(),
  ),
  (Route<dynamic> route) => false, // Predicate always returns false
);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.22,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColor.textWhiteColor, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            color: AppColor.textWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
