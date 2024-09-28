import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/widgets/reservationother.dart';
import 'package:travelappuser/view/widgets/reservationrestaurent.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/reservationservice.dart';

class Reservation extends StatelessWidget {
  final controllerAuth = Get.find<Authentification>();
  final controller = Get.put(ReservationService());

  Reservation({super.key});
  Widget build(context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
      child: Column(
        children: [
          const Text("Reservation List",
              style: TextStyle(color: Colors.black, fontSize: 25)),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("reservation")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.requireData.docs;
                  List<Map<String, dynamic>> list = [];
                  for (var a in data) {
                    if (a.data()["email"] == controllerAuth.user!.email) {
                      list.add(a.data());
                    }
                  }
                  var newlist = list.toList();
                  newlist.sort(
                    (a, b) {
                      var aux = a["date"] as Timestamp;

                      var aux2 = b["date"] as Timestamp;
                      if (aux.toDate().isBefore(aux2.toDate())) return 1;
                      return 0;
                    },
                  );
                  return ListView.builder(
                      itemCount: newlist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              print(newlist[index]);

                              controller.editReservation(
                                  newlist[index], context);
                            },
                            child: newlist[index]['type'] == "hotel"
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                      shadowColor: const Color(0x55434343),
                                      child: Container(
                                          padding:
                                              const EdgeInsetsDirectional.all(
                                                  10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${newlist[index]['datearrive'].toDate()}",
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                        ' ${newlist[index]['type']}')
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${newlist[index]['datesortie'].toDate()}",
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      "status : ${newlist[index]['status']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () {
                                                        controller
                                                            .deleteReservation(
                                                                newlist[index]
                                                                    ['id']);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  )
                                : newlist[index]['type'] == "restaurent"
                                    ? ReservationRestaurent(
                                        status: newlist[index]['status'],
                                        time: newlist[index]['time'],
                                        nomberTable: newlist[index]
                                            ['nombertable'],
                                        id: newlist[index]['id'])
                                    : ReservationOther(
                                        status: newlist[index]['status'],
                                        nomberTable: newlist[index]
                                            ['nomberpersonne'],
                                        id: newlist[index]["id"]));
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    ));
  }
}
