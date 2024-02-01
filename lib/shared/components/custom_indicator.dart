import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BuildCustomIndicator extends StatelessWidget {
  final List<String> numberOfIndicators;
  final CarouselController controller;
  final int sliderIndex;
  final double? smoothColor;

  const BuildCustomIndicator({
    super.key,
    required this.numberOfIndicators,
    required this.controller,
    required this.sliderIndex,
    this.smoothColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numberOfIndicators.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => controller.animateToPage(
            entry.key,
            curve: Curves.fastOutSlowIn,
          ),
          child: Container(
            width: sliderIndex == entry.key ? 40 : 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius:
                  sliderIndex == entry.key ? BorderRadius.circular(14) : null,
              shape: sliderIndex == entry.key
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(sliderIndex == entry.key ? 1.0 : 0.5),
            ),
          ),
        );
      }).toList(),
    );
  }
}
