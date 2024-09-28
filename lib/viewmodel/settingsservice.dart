import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelappuser/view/welcomescreen/welcomescreen.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/navbarservice.dart';

class SettingsService extends GetxController {
  final controllerAuth = Get.find<Authentification>();
  final controllerNavBar = Get.put(NavBarService());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();
  var name = "";
  var phone = "";
  var location = "";
  var email = "";
  var password = "";
  Future<void> loadProfile() async {
    print(controllerAuth.user!.email);
    try {
      QuerySnapshot res = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: controllerAuth.user!.email)
          .get();
      Map<String, dynamic>? data = res.docs[0].data() as Map<String, dynamic>?;
      nameController.text = data?['name'];
      emailController.text = data?['email'];
      passwordController.text = data?['password'];
      locationController.text = data?["location"];
      phoneController.text = data?["phone"];
      name = data?["name"];
      password = data?["password"];
      email = data?["email"];
      location = data?["location"];
      phone = data?["phone"];
    } catch (e) {
      print(e);
    }
  }

  void cancel() {
    nameController.text = name;
    emailController.text = email;
    passwordController.text = password;
    locationController.text = location;
    phoneController.text = phone;
  }

  void updateUser(BuildContext context) async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: controllerAuth.user!.email)
        .limit(1)
        .get();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(res.docs.first.id)
        .update({
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "location": locationController.text,
      "phone": phoneController.text,
    });
    name = nameController.text;
    password = passwordController.text;
    location = locationController.text;
    phone = phoneController.text;
    email = emailController.text;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Profile Update succusfully"),
            actions: [
              TextButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void SingOut(BuildContext context) async {
    final controller = Get.find<Authentification>();
    controller.isConnected = false.obs;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("connected", false);
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      controllerNavBar.selectedIndex = 0.obs;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return WelcomeScreen();
      }));

      print(prefs.getBool("connected"));
    } catch (e) {}
  }
}
