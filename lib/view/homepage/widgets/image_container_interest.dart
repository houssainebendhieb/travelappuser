import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:travelappuser/viewmodel/homepage/detailservice.dart';

class ImageContainerInterest extends StatelessWidget {
  final Map<String, dynamic> data;
  ImageContainerInterest({Key? key, required this.data}) : super(key: key);
  final controllerServiceDetail = Get.find<DetailService>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.58,
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.topCenter,
            child: FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Hero(
                tag: data['urlImage'],
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      data["urlImage"],
                      scale: 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        /*  Positioned(
          top: 30,
          right: 50,
          child: FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: ClipOval(
                child: Obx(
              () => Container(
                child: ClipOval(
                  child: IconButton(
                      onPressed: () async {
                        await controllerServiceDetail.updateFavorite(
                            data["id"], context);
                      },
                      icon: Icon(Icons.favorite,
                          size: 30,
                          color: controllerServiceDetail.isFavorite.isTrue
                              ? Colors.red
                              : Colors.white)),
                ),
              ),
            )),
          ),
        ),*/
      ],
    );
  }
}
