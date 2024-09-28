import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/servicedetail.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});
  final controllerDetailService = Get.put(DetailService());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events List"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Center(
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("service")
                          .where("category", isEqualTo: "event")
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docChanges.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> dataService = {};
                              dataService = snapshot.data!.docChanges[index].doc
                                  .data() as Map<String, dynamic>;

                              return GestureDetector(
                                  onTap: () async {
                                    await controllerDetailService
                                        .checkFavorite(dataService["id"]);
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ServiceDetail(data: dataService);
                                    }));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                      shadowColor: const Color(0x55434343),
                                      child: Container(
                                          child: Row(
                                        children: [
                                          Container(
                                              height: 150,
                                              width: 150,
                                              child: Image.network(
                                                  dataService['urlImages'][0])),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Text(
                                                "${dataService["name"]}",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        color: Colors
                                                            .grey.shade600),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      '${dataService["location"]}',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                            ],
                                          )
                                        ],
                                      )),
                                    ),
                                  ));

                              /* ServiceCard(
                                        images: dataService['urlImages'],
                                        name: dataService["name"],
                                        location: dataService['location'],
                                      ))*/
                            },
                          );
                        }
                        return Container(
                          height: 250,
                          child: Text("soon"),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
