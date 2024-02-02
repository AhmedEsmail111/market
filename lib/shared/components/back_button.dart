import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/helper_functions.dart';

import '../styles/colors.dart';

class BuildBackButton extends StatelessWidget {
  final bool hasBackground;
  final Color? darkBackground;
  const BuildBackButton({
    super.key,
    this.hasBackground = false,
    this.darkBackground,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return Container(
      margin: hasBackground ? EdgeInsets.symmetric(vertical: 16.h) : null,
      decoration: BoxDecoration(
        borderRadius: hasBackground ? BorderRadius.circular(14) : null,
        color: darkBackground,
      ),
      child: IconButton(
        padding: HelperFunctions.isLocaleEnglish()
            ? EdgeInsets.only(left: 8.h)
            : EdgeInsets.only(right: 8.h),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 26.w,
          color: isDark ? Colors.white : null,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
