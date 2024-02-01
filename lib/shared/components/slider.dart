import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '/shared/components/image_placeholder.dart';

class BuildSlider extends StatelessWidget {
  final List<String> images;
  final CarouselController controller;
  final double height;
  final double width;
  final double viewPort;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  const BuildSlider({
    super.key,
    required this.images,
    required this.controller,
    required this.height,
    required this.width,
    this.onPageChanged,
    required this.viewPort,
  });
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      carouselController: controller,
      itemBuilder: (context, index, _) {
        return BuildImagePlaceholder(
          image: images[index],
          imageHeight: height,
          imageWidth: width,
          fit: BoxFit.cover,
        );
      },
      options: CarouselOptions(
        height: height,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        viewportFraction: viewPort,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
