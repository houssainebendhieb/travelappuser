import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/form.dart';
import 'package:travelappuser/view/homepage/formhotel.dart';
import 'package:travelappuser/view/homepage/formrestaurant.dart';
import 'package:travelappuser/viewmodel/form/fomrhotelservice.dart';
import 'package:travelappuser/viewmodel/form/formrestaurentservice.dart';
import 'package:travelappuser/viewmodel/form/formservice.dart';

class ReservationService extends GetxController {
  Map<String, dynamic> dataReservation = {};

  void editReservation(Map<String, dynamic> data, BuildContext context) {
    dataReservation = data;

    //controller.endDate =DateTime.fromMillisecondsSinceEpoch(data["datearrive"]);
    //controller.startDate =DateTime.fromMillisecondsSinceEpoch(data["datesortie"]);

    if (data["type"] == "hotel") {
      final controller = Get.put(FormHotelService());
      controller.nomberNuitsController.text = data['nombrenuit'];
      controller.nomberAdultController.text = data["nombreadult"];
      controller.nomberEnfantsController.text = data["nombreenfant"];
      controller.selectedOption.value = data['pension'];
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const FormHotel(
          isEdit: true,
        );
      }));
    } else if (data['type'] == "restaurent") {
      final controller = Get.put(FormRestaurentService());
      controller.controllerTime.text = data['time'];
      controller.controllerNomberTable.text = data['nombertable'];
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FormRestaurant(isEdit: true);
      }));
    } else {
      final controller = Get.put(FormService());
      controller.commentController.text = data['comment'];
      controller.nomberPersonneController.text = data['nomberpersonne'];
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FormReservation(isEdit: true);
      }));
    }
  }

  Future<void> deleteReservation(String id) async {
    try {
      QuerySnapshot res = await FirebaseFirestore.instance
          .collection("reservation")
          .where("id", isEqualTo: id)
          .get();
      await FirebaseFirestore.instance
          .collection("reservation")
          .doc(res.docs.first.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
