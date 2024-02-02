import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shop_app/controller/addresses/addresses_cubit.dart';
import 'package:shop_app/models/addresses/addresses_model.dart';

import '../../shared/styles/colors.dart';

class BuildAddressesItem extends StatelessWidget {
  final Address address;
  final void Function()? onLongPress;

  final void Function()? onTap;
  final bool withColor;
  const BuildAddressesItem({
    super.key,
    required this.address,
    this.onLongPress,
    this.onTap,
    this.withColor = true,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    // print(address.id);
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Material(
        elevation: withColor ? 1 : 0,
        shadowColor: isDark ? null : AppColors.borderColor,
        color: isDark ? AppColors.blackColor : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16.w,
                        color: isDark
                            ? Colors.white
                            : Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '0${address.phone.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.information,
                        size: 16.w,
                        color: isDark
                            ? Colors.white
                            : Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          address.details,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.map,
                        size: 16.w,
                        color: isDark
                            ? Colors.white
                            : Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${address.city} - ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        address.region,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              if (AddressesCubit.get(context).chosenAddressId == address.id &&
                  withColor)
                Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
