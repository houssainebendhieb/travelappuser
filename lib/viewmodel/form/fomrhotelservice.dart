import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/login.dart';
import 'package:travelappuser/view/widgets/calendar_popup.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/reservationservice.dart';
import 'package:uuid/uuid.dart';

class FormHotelService extends GetxController {
  final controller = Get.put(Authentification());

  RxString selectedOption = "Demi Pension".obs;
  final nomberAdultController = TextEditingController();
  final nomberEnfantsController = TextEditingController();
  final nomberNuitsController = TextEditingController();
  final dateArriveeController = TextEditingController();
  final dateSortieController = TextEditingController();
  void handleRadioValueChange(String? value) {
    selectedOption.value = value!;
  }

  void addReservationHotel(BuildContext context) async {
    var uuid = const Uuid();

    // Generate a v1 (time-based) id
    var v1 = uuid.v1();
    if (controller.isConnected!.isTrue) {
      /*final smtpServer = gmail("houssaine203@gmail.com", "Houssaine203@");
      // Create our message.
      final message = Message()
        ..from = const Address("houssaine203@gmail.com", ' Mr Mokhles Lajmi')
        ..recipients.add('houssaine.bendhieb@isimg.tn')
        ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}';*/

      /* try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }*/
      await FirebaseFirestore.instance.collection("reservation").add({
        "date": DateTime.now(),
        "email": controller.user!.email,
        "type": "hotel",
        "nombreadult": nomberAdultController.text,
        "nombreenfant": nomberEnfantsController.text,
        "nombrenuit": nomberNuitsController.text,
        "datearrive": startDate,
        "datesortie": endDate,
        "pension": selectedOption.value,
        'id': v1,
        "status": "pending"
      });

      nomberAdultController.clear();
      nomberEnfantsController.clear();
      nomberNuitsController.clear();
      dateArriveeController.clear();
      dateSortieController.clear();
      /*  QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Fetching your data',
      );*/
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

  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now();
  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          startDate = startData;
          endDate = endData;
        },
        onCancelClick: () {},
      ),
    );
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
      "type": "hotel",
      "nombreadult": nomberAdultController.text,
      "nombreenfant": nomberEnfantsController.text,
      "nombrenuit": nomberNuitsController.text,
      "datearrive": startDate,
      "datesortie": endDate,
      "pension": selectedOption.value,
      "status": "pending"
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
