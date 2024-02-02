import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';

class BuildLanguageTile extends StatelessWidget {
  final String text;
  final bool isClicked;
  final void Function(bool? status)? onClick;

  const BuildLanguageTile({
    super.key,
    required this.text,
    required this.isClicked,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return CheckboxListTile(
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
      value: isClicked,
      side: BorderSide(
          color:
              isDark ? Colors.white : Theme.of(context).colorScheme.secondary),
      checkColor: Theme.of(context).colorScheme.onPrimary,
      onChanged: (status) {
        onClick!(status);
      },
    );
  }
}
