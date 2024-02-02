import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '/shared/components/back_button.dart';

class BuildRowLikeAppBar extends StatelessWidget {
  // final Color color;
  final String text;

  const BuildRowLikeAppBar({
    super.key,
    // required this.color,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return Row(
      children: [
        BuildBackButton(
          hasBackground: true,
          darkBackground: isDark
              ? Colors.grey.shade700
              : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          alignment: Alignment.center,
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 22.sp)),
        ),
      ],
    );
  }
}
