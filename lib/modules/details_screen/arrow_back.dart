import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/helper_functions.dart';

class BuildArrowBack extends StatelessWidget {
  const BuildArrowBack({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: 55.w,
          height: 55.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.w),
            child: Container(
              padding: HelperFunctions.isLocaleEnglish()
                  ? EdgeInsets.only(left: 10.w)
                  : EdgeInsets.only(right: 10.w),
              width: 55.w,
              height: 55.w,
              decoration: BoxDecoration(
                // color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
