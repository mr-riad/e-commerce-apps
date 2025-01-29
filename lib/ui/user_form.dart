import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_apps/const/AppColors.dart';
import 'package:e_commerce_apps/ui/bottom_nav_controller.dart';
import 'package:e_commerce_apps/widgets/myTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/customButton.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final List<String> gender = ["Male", "Female", "Other"];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkUserAuth();
  }

  // Check if user is authenticated
  void _checkUserAuth() async {
    User? user = _auth.currentUser;
    if (user == null) {
      print("User not logged in!");
    } else {
      print("Logged in as: ${user.email}");
    }
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> sendUserDataToDB() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      print("User Email: ${currentUser.email}");

      CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("users-form-data");

      try {
        await _collectionRef.doc(currentUser.uid).set({
          "name": _nameController.text.trim(),
          "phone": _phoneController.text.trim(),
          "dob": _dobController.text.trim(),
          "gender": _genderController.text.trim(),
          "age": _ageController.text.trim(),
          "email": currentUser.email,
        });

        print("Data saved successfully!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BottomNavController()),
        );
      } catch (e) {
        print("Error saving data: $e");
      }
    } else {
      print("No user logged in!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Submit the form to continue.",
                  style: TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(fontSize: 14.sp, color: Color(0xFFBBBBBB)),
                ),
                SizedBox(height: 15.h),
                myTextField("Enter your name", TextInputType.text, _nameController),
                myTextField("Enter your phone number", TextInputType.phone, _phoneController),

                // Date of Birth
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),

                // Gender Selection
                DropdownButtonFormField<String>(
                  value: _genderController.text.isEmpty ? null : _genderController.text,
                  items: gender.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _genderController.text = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Choose your gender",
                  ),
                ),

                myTextField("Enter your age", TextInputType.number, _ageController),

                SizedBox(height: 50.h),

                // Submit Button
                customButton("Continue", () => sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
