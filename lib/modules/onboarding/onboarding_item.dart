import 'package:flutter/material.dart';
import 'package:shop_app/models/onboarding/onboarding_model.dart';

class BuildOnBoardingItem extends StatelessWidget {
  final BoardingModel model;
  const BuildOnBoardingItem({
    super.key,
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          child: Image.asset(
            model.image,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.4,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          model.title,
          style: const TextStyle().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          model.body,
          style: const TextStyle().copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
