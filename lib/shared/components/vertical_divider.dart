import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildVerticalDivider extends StatelessWidget {
  final double height;
  const BuildVerticalDivider({super.key, required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 2.w,
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
    );
  }
}
