import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/shared/components/discount_percent.dart';
import 'package:shop_app/shared/helper_functions.dart';

import '../styles/colors.dart';
import '/models/home/home_model.dart';
import '/shared/components/fave_icon.dart';

class BuildRowPriceFav extends StatelessWidget {
  final Product product;
  final String? optionalText;
  final bool withFav;
  const BuildRowPriceFav({
    super.key,
    required this.product,
    this.optionalText,
    this.withFav = true,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return Row(
      children: [
        if (optionalText != null)
          Padding(
            padding: HelperFunctions.isLocaleEnglish()
                ? EdgeInsets.only(right: 5.w)
                : EdgeInsets.only(left: 5.w),
            child: Text(
              '$optionalText : ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        Text(
          '${product.price.toStringAsFixed(0)}\$',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(
          width: 4.w,
        ),
        if (product.discount != null && product.discount != 0)
          Text(
            '${product.oldPrice!.toStringAsFixed(0)}\$',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                // decorationThickness: isDark ? 2 : 1,
                decorationColor: isDark
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary),
          ),
        if (optionalText != null &&
            product.oldPrice != null &&
            product.discount != null &&
            product.discount != 0)
          BuildDiscountPercent(
              text:
                  '- ${(((product.price - product.oldPrice!) / product.oldPrice!) * 100).toStringAsFixed(2).substring(1)}%'),
        const Spacer(),
        if (withFav) BuildFavIcon(id: product.id),
      ],
    );
  }
}
