import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailInfo extends StatelessWidget {
  final String title;
  final String rawRating;
  final String price;
  final String location;

  const DetailInfo({
    Key? key,
    required this.title,
    required this.rawRating,
    required this.price,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 900),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey.shade600),
                        GestureDetector(
                          onTap: () {
                            openMapWithName(location);
                          },
                          child: Text(location,
                              style: TextStyle(color: Colors.grey.shade600)),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      price != "" ? 'per night' : "",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
        ],
      ),
    );
  }

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
}
