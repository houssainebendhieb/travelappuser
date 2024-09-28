import 'package:flutter/material.dart';
import 'package:travelappuser/view/homepage/widgets/big_card_image_slide.dart';

class ServiceCard extends StatelessWidget {
  final List<dynamic> images;
  final String name;
  final String location;

  ServiceCard({
    Key? key,
    required this.name,
    required this.location,
    required this.images,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass list of images here
          BigCardImageSlide(images: images),
          const SizedBox(height: 16 / 2),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16 / 4),
          // PriceRangeAndFoodtype(foodType: foodType),
          const SizedBox(height: 16 / 4),
          Row(
            children: [
              Text("$location"),
              SizedBox(width: 16 / 2),
            ],
          ),
        ],
      ),
    );
  }
}

class PriceRangeAndFoodtype {}
