import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/viewmodel/reservationservice.dart';

class ReservationRestaurent extends StatelessWidget {
  final String time;
  final String nomberTable;
  final String id;
  final String status;
  ReservationRestaurent(
      {super.key,
      required this.status,
      required this.time,
      required this.nomberTable,
      required this.id});
  final controller = Get.put(ReservationService());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: const Color(0x55434343),
        child: Container(
            padding: const EdgeInsetsDirectional.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Time :"),
                      Text(time),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text("nb table:"),
                          Text(nomberTable)
                        ]),
                        Row(
                          children: [
                            Text(
                              "status :",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                                child: Text(status,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        )
                      ]),
                ),
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteReservation(id);
                        },
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
