import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelappuser/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelappuser/view/navbar.dart';
import 'package:travelappuser/view/welcomescreen/welcomescreen.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/settingsservice.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isConnected = prefs.getBool('connected') ?? false;
  final controller = Get.put(Authentification());
  final controllerSettings = Get.put(SettingsService());
  // final controllerHomePage = Get.put(HomePageService());
  //await controllerHomePage.determinePosition();
  controller.isConnected = isConnected == true ? true.obs : false.obs;
  if (isConnected) {
    final email = prefs.getString("email");
    final password = prefs.getString("password");
    controller.user = User(email: email!, password: password!);
    await controllerSettings.loadProfile();
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isConnected == false ? WelcomeScreen() : NavigationBarApp(),
  ));
}
