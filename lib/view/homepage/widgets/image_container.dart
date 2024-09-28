import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travelappuser/view/homepage/widgets/image_reviews.dart';
import 'package:travelappuser/viewmodel/homepage/detailservice.dart';

class ImageContainer extends StatefulWidget {
  final Map<String, dynamic> data;
  ImageContainer({Key? key, required this.data}) : super(key: key);

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  final controllerServiceDetail = Get.find<DetailService>();

  @override
  Widget build(BuildContext context) {
    List<dynamic> listImages = widget.data["urlImages"];
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
                tag: listImages.length > 0
                    ? listImages[0]
                    : Icon(Icons.image_not_supported_outlined),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      listImages.length > 0
                          ? listImages[0]
                          : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUrgu4a7W_OM8LmAuN7Prk8dzWXm7PVB_FmA&s",
                      scale: 4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 50,
          child: FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: ClipOval(
                child: Obx(
              () => Container(
                child: ClipOval(
                  child: IconButton(
                      onPressed: () {
                        controllerServiceDetail.updateFavorite(
                            widget.data["id"], context);
                        setState(() {});
                      },
                      icon: Icon(Icons.favorite,
                          size: 30,
                          color: controllerServiceDetail.isFavorite.isTrue
                              ? Colors.red
                              : Colors.grey)),
                ),
              ),
            )),
          ),
        ),
        listImages.length > 0
            ? ImageReviews(images: widget.data['urlImages'])
            : Container(),
      ],
    );
  }
}
