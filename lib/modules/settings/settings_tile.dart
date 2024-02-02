import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';

class BuildSettingsTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final bool withSwitchIcon;
  final void Function()? onClick;
  final void Function(bool status)? onSwitchToggled;
  final bool? switchStatus;

  const BuildSettingsTile({
    super.key,
    required this.icon,
    required this.text,
    required this.withSwitchIcon,
    required this.onClick,
    required this.iconColor,
    this.onSwitchToggled,
    this.switchStatus,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return ListTile(
      dense: true,
      horizontalTitleGap: 8.w,
      onTap: onClick,
      leading: Icon(icon, color: iconColor),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14.sp,
              color: iconColor == Theme.of(context).colorScheme.error
                  ? Theme.of(context).colorScheme.error
                  : isDark
                      ? null
                      : Colors.black,
            ),
      ),
      trailing: withSwitchIcon
          ? Switch(
              value: switchStatus!,
              onChanged: withSwitchIcon ? onSwitchToggled : null,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            )
          : null,
    );
  }
}
