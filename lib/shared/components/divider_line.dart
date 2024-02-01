import 'package:flutter/material.dart';

class BuildDividerLine extends StatelessWidget {
  final double thickness;
  final double? height;
  const BuildDividerLine({
    super.key,
    this.thickness = 1,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: height,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        thickness: thickness);
  }
}
