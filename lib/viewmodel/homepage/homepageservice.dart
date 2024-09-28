import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class UserPosition {
  double latitude;
  double longitude;
  UserPosition({required this.latitude, required this.longitude});
}

class HomePageService extends GetxController {
  final searchController = TextEditingController();
  RxString homePageSelectedCategory = "hotel".obs;
  List<Map<String, dynamic>> allService = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> allFavoriteService =
      <Map<String, dynamic>>[].obs;
  List<String> categories = [
    "hotel",
    "restaurant",
    "mosque",
    "amusement park",
    "others"
  ];
  Position? userPosition;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    userPosition = await Geolocator.getCurrentPosition();
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double res = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return res;
  }

  List<Map<String, dynamic>> sortUsersByProximity(
      UserPosition currentPosition, List<Map<String, dynamic>> users) {
    users.sort((a, b) {
      double al = a['latitude'];
      double aa = a['longitude'];
      double bl = b['latitude'];
      double bb = b['longitude'];

      double distanceA = calculateDistance(
          currentPosition.latitude, currentPosition.longitude, al, aa);
      double distanceB = calculateDistance(
          currentPosition.latitude, currentPosition.longitude, bl, bb);
      print(distanceA);
      return distanceA.compareTo(distanceB);
    });

    return users;
  }
}
