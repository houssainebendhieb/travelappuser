import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:travelappuser/view/homepage/widgets/hoteldetail.dart';

import 'package:travelappuser/view/homepage/widgets/otherdetail.dart';
import 'package:travelappuser/view/homepage/widgets/restaurentdetail.dart';
import 'package:travelappuser/viewmodel/authentification.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';
import 'package:travelappuser/viewmodel/interestpointservice.dart';

class ServiceDetail extends StatelessWidget {
  final Map<String, dynamic> data;
  final controllerServiceDetail = Get.find<DetailService>();
  final controllerAuth = Get.find<Authentification>();
  final controllerInterst = Get.put(InterestPointService);
  ServiceDetail({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
//    List<dynamic> urlImages = data['urlImages'];
    // List<dynamic> interstPoint = data['listchildren'];

    return Scaffold(
        backgroundColor: Colors.white,
        body: data['category'] == "hotel"
            ? HotelDetail(
                data: data,
              )
            : data['category'] == "restaurant"
                ? RestaurentDetail(data: data)
                : OtherDetail(data: data));
  }
}
