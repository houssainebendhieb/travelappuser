import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ImageReviews extends StatelessWidget {
  final List<dynamic> images;
  const ImageReviews({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 365,
      left: 24,
      right: 24,
      child: FadeInUp(
        duration: const Duration(milliseconds: 700),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return InstaImageViewer(
              child: Image.network(
                images[index],
                scale: 4,
              ),
            );
          },
        ),
      ),
    );
  }
}
