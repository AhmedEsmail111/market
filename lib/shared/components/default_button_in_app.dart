import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Default Button in my app

class BuildDefaultButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  // final Color color;
  final double elevation;
  final BuildContext? context;
  final Color? color;
  const BuildDefaultButton({
    super.key,
    required this.onTap,
    required this.text,
    // required this.color,
    required this.elevation,
    this.context,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          elevation: elevation,
          backgroundColor: color ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          // backgroundColor: color,
        ),
        onPressed: onTap,
        child: Text(
          text,
          // textDirection: HelperFunctions.isLocaleEnglish()
          //     ? TextDirection.ltr
          //     : TextDirection.rtl,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width / 22.5,
              ),
        ),
      ),
    );
  }
}
