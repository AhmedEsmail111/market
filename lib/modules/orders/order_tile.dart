import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../shared/styles/colors.dart';
import '/models/orders/orders_model.dart';
import '/shared/helper_functions.dart';

class BuildOrderTile extends StatelessWidget {
  final Order order;
  final void Function()? onTap;
  final void Function()? onCancel;
  const BuildOrderTile(
      {super.key, required this.order, this.onTap, this.onCancel});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 1,
          shadowColor: isDark ? null : borderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: BorderSide(
              color: isDark
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                  : borderColor,
            ),
          ),
          color: isDark ? blackColor : Colors.white,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                // margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isDark ? blackColor : Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.status_up_copy,
                          color: isDark ? Colors.deepOrange : null,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${locale.status} :  ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          order.status,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Iconsax.security_time_copy,
                          color: isDark ? Colors.deepOrange : null,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${locale.date} :  ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          order.date,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // color: Theme.of(context).colorScheme.primary,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money_outlined,
                          color: isDark ? Colors.deepOrange : null,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${locale.total} :  ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${order.total.toStringAsFixed(2)}\$',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    // color: Theme.of(context).colorScheme.primary,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (order.status case 'New' || 'جديد')
                Positioned(
                    right: HelperFunctions.isLocaleEnglish() ? 25.w : null,
                    left: !HelperFunctions.isLocaleEnglish() ? 25.w : null,
                    top: 15,
                    child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError),
                        onPressed: onCancel,
                        icon: const Icon(Iconsax.box_remove_copy)))
            ],
          ),
        ),
      ),
    );
  }
}
