import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelappuser/model/user.dart';

class Authentification extends GetxController {
  SharedPreferences? sharedPreferences;

  void changeState(context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const CircularProgressIndicator();
          });
      sharedPreferences = await SharedPreferences.getInstance();
    } catch (e) {
      //
    }

    isConnected =
        sharedPreferences?.get("connected") == true ? true.obs : false.obs;
    Navigator.pop(context);
  }

  User? user;
  RxBool? isConnected;
}
