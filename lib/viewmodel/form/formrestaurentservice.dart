import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/login.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/reservationservice.dart';
import 'package:uuid/uuid.dart';

class FormRestaurentService extends GetxController {
  final controllerNomberTable = TextEditingController();
  final controllerTime = TextEditingController();
  var uuid = const Uuid();
  final controller = Get.put(Authentification());
  // Generate a v1 (time-based) id

  void addResevation(BuildContext context) async {
    final controller = Get.put(Authentification());
    if (controller.isConnected!.isTrue) {
      var v1 = uuid.v1();
      await FirebaseFirestore.instance.collection("reservation").add({
        "date": DateTime.now(),
        "id": v1,
        "type": "restaurent",
        "nombertable": controllerNomberTable.text,
        "time": controllerTime.text,
        "status": "pending",
        "email": controller.user!.email
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Reservation added succfully"),
              actions: [
                TextButton(
                  child: const Text("close"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("you must login before "),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Login();
                    }));
                  },
                )
              ],
            );
          });
    }
  }

  void updateReservation(BuildContext context) async {
    final controller = Get.put(ReservationService());
    print(controller.dataReservation["id"]);
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection("reservation")
        .where("id", isEqualTo: controller.dataReservation["id"])
        .limit(1)
        .get();
    await FirebaseFirestore.instance
        .collection("reservation")
        .doc(res.docs.first.id)
        .update({
      "nombertable": controllerNomberTable.text,
      "time": controllerTime.text,
    });
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
}
