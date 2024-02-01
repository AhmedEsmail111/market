import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/helper_functions.dart';
import '../../shared/styles/colors.dart';
import '/models/home/home_model.dart';
import '/modules/details_screen/add_to_cart.dart';
import '/shared/components/divider_line.dart';
import '/shared/components/row_price__fav.dart';

class BuildDraggableContainer extends StatelessWidget {
  final Product product;
  const BuildDraggableContainer({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    // print(product.description);
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: ((context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isDark ? darKBackground : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: ListView(
              padding: EdgeInsets.only(bottom: 30.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, bottom: 20.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5),
                        ),
                        height: 5.h,
                        width: 32.w,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: HelperFunctions.isTextEnglish(product.name!)
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    product.name!,
                    textDirection: HelperFunctions.isTextEnglish(product.name!)
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child: BuildRowPriceFav(
                    product: product,
                    optionalText: locale.price,
                  ),
                ),
                const BuildDividerLine(),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 8.h),
                Text(
                  product.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.visible,
                  maxLines: null,
                ),
                SizedBox(height: 12.h),
                BuildAddToCart(
                  id: product.id,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
