import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/widgets/detail_info.dart';
import 'package:travelappuser/view/homepage/widgets/image_container_interest.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';
import 'package:travelappuser/viewmodel/interestpointservice.dart';
import 'package:url_launcher/url_launcher.dart';

void openMapWithName(String locationName) async {
  String encodedLocationName = Uri.encodeComponent(locationName);
  String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$encodedLocationName";
  String appleMapsUrl = "https://maps.apple.com/?q=$encodedLocationName";

  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  } else if (await canLaunch(appleMapsUrl)) {
    await launch(appleMapsUrl);
  } else {
    throw 'Could not launch maps';
  }
}

class InterestPointDetail extends StatelessWidget {
  final Map<String, dynamic> data;
  final controllerServiceDetail = Get.find<DetailService>();
  final controllerAuth = Get.find<Authentification>();
  final controllerInterst = Get.put(InterestPointService);
  InterestPointDetail({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
//    List<dynamic> urlImages = data['urlImages'];

    return Scaffold(
      body: Stack(children: [
        ListView(
          children: <Widget>[
            ImageContainerInterest(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    data["name"],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "About".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        data['about'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Location".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          openMapWithName(data['location']);
                        },
                        child: Text(
                          data['location'],
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        /* data["booking"] == true
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
                      "Book Now",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    onPressed: () {
                      controllerServiceDetail.booking(
                          context, data['category']);
                    },
                  ),
                ),
              )
            : Container(),*/
        Positioned(
          top: 20,
          left: 20,
          child: FadeInUp(
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
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
