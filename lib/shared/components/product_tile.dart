import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/modules/details_screen/details_screen.dart';
import 'package:shop_app/shared/components/row_price__fav.dart';
import 'package:shop_app/shared/components/sale_container.dart';
import 'package:shop_app/shared/helper_functions.dart';

import '../../models/home/home_model.dart';
import '../styles/colors.dart';
import '/shared/components/image_placeholder.dart';

class BuildProductTile extends StatelessWidget {
  final Product product;

  final bool withFav;
  const BuildProductTile({
    super.key,
    required this.product,
    this.withFav = true,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    return InkWell(
      onTap: withFav
          ? () {
              HelperFunctions.pushScreen(
                context,
                DetailsScreen(
                  product: product,
                ),
              );
            }
          : null,
      child: Material(
        elevation: 1,
        shadowColor: isDark ? null : AppColors.borderColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
            side: BorderSide(
                color: isDark
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : AppColors.borderColor)),
        color: isDark ? AppColors.blackColor : Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark
                  ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                  : AppColors.borderColor,
            ),
            color: isDark ? AppColors.blackColor : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          height: 100.h,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100.w,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    BuildImagePlaceholder(
                      image: product.image,
                      imageHeight: 80.h,
                      imageWidth: 100.w,
                    ),
                    if (product.discount != null && product.discount != 0)
                      const BuildSaleContainer(),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: HelperFunctions.isTextEnglish(product.name!)
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        product.name!,
                        maxLines: 2,
                        textDirection:
                            HelperFunctions.isTextEnglish(product.name!)
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                        child: BuildRowPriceFav(
                      withFav: withFav,
                      product: product,
                    )),
                  ],
                ),
              ),
            ],
            // trailing: const Icon(
            //   Icons.arrow_forward_ios,
            // ),
          ),
        ),
      ),
    );
  }
}
