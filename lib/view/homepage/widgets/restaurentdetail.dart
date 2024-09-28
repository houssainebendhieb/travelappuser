import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:travelappuser/view/homepage/interestpointdetail.dart';
import 'package:travelappuser/view/homepage/widgets/detail_info.dart';
import 'package:travelappuser/view/homepage/widgets/image_container.dart';
import 'package:travelappuser/view/homepage/widgets/offeritem.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';
import 'package:travelappuser/viewmodel/interestpointservice.dart';

class RestaurentDetail extends StatelessWidget {
  final Map<String, dynamic> data;
  final controllerServiceDetail = Get.find<DetailService>();
  final controllerAuth = Get.find<Authentification>();
  final controllerInterst = Get.put(InterestPointService);
  RestaurentDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<dynamic> interstPoint = data['listchildren'];
    List<dynamic> listFeature = data["specialfeature"] as List;
    print("i am here");
    print(listFeature);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Stack(children: [
        ListView(
          children: <Widget>[
            ImageContainer(
              data: data,
            ),
            DetailInfo(
              location: data["location"],
              price: data['pricepernight'] != null ? data['pricepernight'] : "",
              rawRating: "5 0",
              title: data['name'],
            )
            /*  Container(
                  foregroundDecoration: const BoxDecoration(color: Colors.black26),
                  height: 400,
                  child: Image.network(data['urlImages'][0], fit: BoxFit.cover)),*/
            ,
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //const SizedBox(height: 250),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      data["haswifi"] != null
                          ? data['haswifi'] == true
                              ? offerItem(Icons.wifi, "free wifi")
                              : Container()
                          : Container(),
                      data['smokeplace'] != null
                          ? data["smokeplace"] == true
                              ? offerItem(
                                  Icons.smoking_rooms_rounded, "smoking place")
                              : Container()
                          : Container(),
                      data['hasoutdoorseating'] != null
                          ? data["hasoutdoorseating"] == true
                              ? offerItem(
                                  Icons.deck_outlined, "Outdoor Seating")
                              : Container()
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("About".toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 1.0),
                        ReadMoreText(
                          data['about'],
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '..Read More',
                          trimExpandedText: ' Less',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  const Icon(Icons.access_time_outlined,
                                      color: Colors.blue),
                                  Text(
                                    "open at ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    "${data['openinghours']}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 80,
                              width: 85,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  const Icon(Icons.event_seat,
                                      color: Colors.blue),
                                  Text(
                                    "Reservation: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600),
                                  ),
                                  Text(
                                    "${data['reservationpolicy']}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade600),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        listFeature.length > 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 00),
                                child: Text(
                                  "Special Feature".toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                                ),
                              )
                            : Container(),
                        listFeature.length > 0
                            ? Container(
                                height: 160,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listFeature.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade100),
                                        width: 155,
                                        child: ClipOval(
                                          child: Image.network(
                                              data["specialfeature"][index]),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 15),
                        Text(
                          "Interst Point".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 0),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          height: 160,
                          child: ListView.builder(
                              itemCount: interstPoint.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection("interestpoint")
                                        .where("id",
                                            isEqualTo: interstPoint[index])
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map<String, dynamic> aux = snapshot
                                            .data!.docChanges.first.doc
                                            .data() as Map<String, dynamic>;
                                        print(snapshot
                                            .data!.docChanges.first.doc
                                            .data());
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              controllerServiceDetail.data =
                                                  aux;
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return InterestPointDetail(
                                                  data: aux,
                                                );
                                              }));
                                            },
                                            child: Container(
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 8,
                                                            right: 8),
                                                    child: Image.network(
                                                        snapshot
                                                                .data!
                                                                .docChanges
                                                                .first
                                                                .doc
                                                                .data()?[
                                                            'urlImage']),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Text(snapshot.data!
                                                        .docChanges.first.doc
                                                        .data()?['name']),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.location_on,
                                                            color: Colors.blue),
                                                        Text(snapshot
                                                                .data!
                                                                .docChanges
                                                                .first
                                                                .doc
                                                                .data()?[
                                                            'location'])
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Text("no interest point");
                                      }
                                    });
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Column(
                            children: [],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Contact".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.mail, color: Colors.blue),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(data['email'],
                                style: const TextStyle(fontSize: 16))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone, color: Colors.blue),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(data['phone'],
                                style: const TextStyle(fontSize: 16))
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        data["booking"] == true
            ? Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                    ),
                    child: const Text(
                      "Book  Now",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      controllerServiceDetail.booking(
                          context, data['category']);
                    },
                  ),
                ),
              )
            : Container(),
        Positioned(
          top: 50,
          left: 20,
          child: FadeInUp(
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ]),
    );
  }
}
