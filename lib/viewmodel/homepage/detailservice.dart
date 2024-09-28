import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/form.dart';
import 'package:travelappuser/view/homepage/formhotel.dart';
import 'package:travelappuser/view/homepage/formrestaurant.dart';
import 'package:travelappuser/view/login.dart';
import 'package:travelappuser/viewmodel/authentification.dart';

class DetailService extends GetxController {
  final controller = Get.find<Authentification>();
  var isFavorite = false.obs;
  var favorite = false.obs;
  Map<String, dynamic> data = {};

  Future<void> checkFavorite(String id) async {
    if (controller.isConnected != null && controller.isConnected!.isTrue) {
      QuerySnapshot res = await FirebaseFirestore.instance
          .collection("favorites")
          .where("idservice", isEqualTo: id)
          .where("email", isEqualTo: controller.user!.email)
          .limit(1)
          .get();
      if (res.docs.isEmpty) {
        isFavorite = false.obs;
      } else {
        isFavorite = true.obs;
      }
    } else {
      isFavorite = false.obs;
    }
  }

  void updateFavorite(String id, BuildContext context)  {
    if (isFavorite.isFalse) {
      isFavorite.value = !isFavorite.value;
      addFavorite(id, context);
    } else {
      isFavorite.value = !isFavorite.value;
      deleteFavorite(id);
    }
  }

  void addFavorite(String id, BuildContext context) async {
    if (controller.isConnected!.isTrue) {
      await FirebaseFirestore.instance
          .collection("favorites")
          .add({"email": controller.user!.email, "idservice": id});
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
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    Navigator.pushReplacement(context,
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

  void deleteFavorite(String id) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Get a reference to the collection
      CollectionReference collectionRef = firestore.collection("favorites");

      // Query the collection for the document with the specified name
      QuerySnapshot querySnapshot =
          await collectionRef.where('idservice', isEqualTo: id).get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String documentId = querySnapshot.docs.first.id;

        // Delete the document
        await collectionRef.doc(documentId).delete();
      } else {}
    } catch (e) {
      //
    }
  }

  void booking(BuildContext context, String form) async {
    if (controller.isConnected!.isTrue) {
      if (form == "hotel") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const FormHotel(
            isEdit: false,
          );
        }));
      } else if (form == "restaurant") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormRestaurant(
            isEdit: false,
          );
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormReservation(isEdit: false);
        }));
      }
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
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    Navigator.pushReplacement(context,
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
}
