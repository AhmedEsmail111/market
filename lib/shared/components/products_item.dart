import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/modules/details_screen/details_screen.dart';
import 'package:shop_app/shared/components/image_placeholder.dart';
import 'package:shop_app/shared/components/row_price__fav.dart';
import 'package:shop_app/shared/components/sale_container.dart';
import 'package:shop_app/shared/helper_functions.dart';
import 'package:shop_app/shared/styles/colors.dart';

// card that contain about post books

class BuildProductsItem extends StatelessWidget {
  final Product product;
  final int index;
  final void Function() onTap;

  const BuildProductsItem({
    super.key,
    required this.product,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // // final locale = AppLocalizations.of(context);
    // final time = DateTime.now().difference(timeSince).inDays;
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;

    return GestureDetector(
      onTap: () {
        HelperFunctions.pushScreen(
          context,
          DetailsScreen(product: product),
        );
      },
      child: Material(
        elevation: 1,
        shadowColor: isDark ? null : borderColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: isDark
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : borderColor)),
        color: isDark ? blackColor : Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            color: isDark ? blackColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(
            //     color: isDark
            //         ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
            //         : darkBorderColor)
            // border: cardBorder,
          ),
          padding: EdgeInsets.all(8.w),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  BuildImagePlaceholder(
                    image: product.image,
                    imageHeight: 120.h,
                    imageWidth: 150.w,
                  ),
                  if (product.discount != 0) const BuildSaleContainer()
                ],
              ),

              SizedBox(
                height: 4.h,
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              BuildRowPriceFav(product: product),

              // Row(
              //   children: [
              //     Icon(
              //       SolarIconsOutline.book,
              //       size: 10.h,
              //     ),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Text(
              //       '$numberOfBooks',
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodyMedium!
              //           .copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500),
              //     ),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Icon(
              //       SolarIconsOutline.eye,
              //       size: 10.h,
              //     ),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Text(
              //       '$numberOfWatcher',
              //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //             fontSize: 10.sp,
              //             fontWeight: FontWeight.w500,
              //           ),
              //     ),
              //     const Spacer(),
              //     BuildPriceContainer(price: price, locale: locale),
              //   ],
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 4.h),
              //   child: Text(
              //     reversEducationLevels[educationLevel]!,
              //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //           fontSize: 10.sp,
              //           fontWeight: FontWeight.w400,
              //         ),
              //     textDirection: HelperFunctions.isArabic(educationLevel)
              //         ? TextDirection.rtl
              //         : TextDirection.ltr,
              //   ),
              // ),
              // Row(
              //   children: [
              //     Icon(
              //       SolarIconsOutline.mapPoint,
              //       size: 10.h,
              //     ),
              //     SizedBox(
              //       width: 2.w,
              //     ),
              //     Text(
              //       city ?? '',
              //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //             fontSize: 10.sp,
              //             fontWeight: FontWeight.w500,
              //           ),
              //       textDirection: HelperFunctions.isArabic(city ?? '')
              //           ? TextDirection.rtl
              //           : TextDirection.ltr,
              //       overflow: TextOverflow.ellipsis,
              //       softWrap: true,
              //     ),
              //     SizedBox(
              //       width: 4.w,
              //     ),
              //     const Spacer(),
              //     Icon(
              //       SolarIconsOutline.clockCircle,
              //       size: 10.h,
              //     ),
              //     SizedBox(
              //       width: 2.w,
              //     ),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width / 6.7,
              //       child: Text(
              //         locale.time_since('$time $timeText'),
              //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //               fontSize: 10.sp,
              //               fontWeight: FontWeight.w500,
              //             ),
              //         overflow: TextOverflow.ellipsis,
              //         softWrap: true,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// custimize the radius and the elevation
// add the logic to home screen
