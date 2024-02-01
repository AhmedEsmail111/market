import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSaleContainer extends StatelessWidget {
  const BuildSaleContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      color: const Color.fromARGB(255, 255, 106, 7),
      child: Text(
        'ON SALE',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.white,
              letterSpacing: 3.0,
            ),
      ),
    );
  }
}
