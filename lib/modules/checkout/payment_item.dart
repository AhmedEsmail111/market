import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/image_placeholder.dart';
import '../../shared/helper_functions.dart';
import '../../shared/styles/colors.dart';

class BuildPaymentItem extends StatelessWidget {
  final String image;
  final String name;
  final void Function()? onTap;
  final int chosenIndex;
  final int currentIndex;
  const BuildPaymentItem({
    super.key,
    required this.image,
    required this.name,
    this.onTap,
    required this.chosenIndex,
    required this.currentIndex,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Material(
            color: isDark ? blackColor : Colors.white,
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(14.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  BuildImagePlaceholder(
                    isAsset: true,
                    image: image,
                    imageHeight: 75.w,
                    imageWidth: 75.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          if (chosenIndex == currentIndex)
            Positioned(
              right: HelperFunctions.isLocaleEnglish() ? 20 : null,
              left: !HelperFunctions.isLocaleEnglish() ? 20 : null,
              top: 35.h,
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: isDark
                      ? Colors.deepOrange
                      : Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 15.w,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
