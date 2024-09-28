import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelappuser/model/user.dart';
import 'package:travelappuser/view/login.dart';
import 'package:travelappuser/view/navbar.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/settingsservice.dart';

class LoginService extends GetxController {
  final controllerAuthentification = Get.put(Authentification());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void SignIn(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final controllerSettings = Get.find<SettingsService>();

    QuerySnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: emailController.text.trim())
        .where("password", isEqualTo: passwordController.text.trim())
        .limit(1)
        .get();
    if (user.docs.isEmpty) {
      print("invalid ");
    } else {
      sharedPreferences.setBool("connected", true);
      sharedPreferences.setString("email", emailController.text);
      sharedPreferences.setString("password", passwordController.text);
      controllerAuthentification.isConnected = true.obs;
      controllerAuthentification.user =
          User(password: passwordController.text, email: emailController.text);
      await controllerSettings.loadProfile();
      emailController.clear();
      passwordController.clear();
      // ignore: use_build_context_synchronously
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return NavigationBarApp();
      }));
    }
  }

  void SingUp(context) async {
    QuerySnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: emailController.text.trim())
        .limit(1)
        .get();
    if (user.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('users').add({
        "email": emailController.text,
        "password": passwordController.text,
        "location": locationController.text,
        "phone": phoneController.text,
        "name": nameController.text
      });
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      phoneController.clear();
      locationController.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email already exist'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      print("already exist");
    }
  }
}
