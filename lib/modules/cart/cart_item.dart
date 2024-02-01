import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../shared/components/build_dialogue.dart';
import '../../shared/helper_functions.dart';
import '../../shared/styles/colors.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/models/cart/cart_model.dart';
import '/shared/components/discount_percent.dart';
import '/shared/components/image_placeholder.dart';

class BuildCartItem extends StatelessWidget {
  final CartItem item;
  final bool showActions;
  const BuildCartItem({super.key, required this.item, this.showActions = true});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    // print(item.id);
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return Material(
          elevation: 1,
          shadowColor: isDark ? null : borderColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
              side: BorderSide(
                  color: isDark
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                      : borderColor)),
          color: isDark ? blackColor : Colors.white,
          clipBehavior: Clip.hardEdge,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? blackColor : Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isDark
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                    : borderColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 8.h,
                left: HelperFunctions.isLocaleEnglish() ? 8.w : 4.w,
                right: HelperFunctions.isLocaleEnglish() ? 4.w : 8.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      SizedBox(
                        // height: 100.h,
                        child: Stack(
                          children: [
                            BuildImagePlaceholder(
                              image: item.product.image,
                              imageHeight: 90.h,
                              imageWidth: 100.w,
                            ),
                            if (item.product.oldPrice != null &&
                                item.product.discount != null &&
                                item.product.discount != 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: BuildDiscountPercent(
                                    text:
                                        '- ${(((item.product.price - item.product.oldPrice!) / item.product.oldPrice!) * 100).toStringAsFixed(2).substring(1)}%'),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Container(
                              alignment: HelperFunctions.isTextEnglish(
                                item.product.name!,
                              )
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              width: 200.w,
                              child: Text(
                                item.product.name!,
                                textDirection: HelperFunctions.isTextEnglish(
                                  item.product.name!,
                                )
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                            alignment: HelperFunctions.isTextEnglish(
                                    item.product.name!)
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            width: 200.w,
                            child: Text(
                              item.product.description,
                              textDirection: HelperFunctions.isTextEnglish(
                                      item.product.name!)
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: 200.w,
                            child: Row(
                              children: [
                                if (!showActions)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          '${locale.quantity}: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 15.sp,
                                              ),
                                        ),
                                        Text(
                                          item.quantity.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Text(
                                          '${locale.total}: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 15.sp,
                                              ),
                                        ),
                                        Text(
                                          '${(item.product.price * item.quantity).toStringAsFixed(0)}\$',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (showActions)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          style: IconButton.styleFrom(
                                            disabledBackgroundColor: isDark
                                                ? Colors.grey
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.2),
                                            backgroundColor: isDark
                                                ? Colors.grey
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.2),
                                          ),
                                          color: Colors.white,
                                          onPressed: state
                                                  is ChangeQuantityInCartLoading
                                              ? null
                                              : () {
                                                  cubit.cartMap[item.id]! - 1 ==
                                                          0
                                                      ? buildDialogue(
                                                          context: context,
                                                          title: locale
                                                              .remove_title,
                                                          message: locale
                                                              .remove_message,
                                                          doText: locale.delete,
                                                          undoText:
                                                              locale.cancel,
                                                          onDelete: () {
                                                            cubit.removeItem(
                                                                item.id);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        )
                                                      : cubit.changeQuantity(
                                                          itemId: item.id,
                                                          quantity: (cubit
                                                                      .cartMap[
                                                                  item.id]! -
                                                              1));
                                                },
                                          icon: Icon(
                                            Iconsax.minus_copy,
                                            size: 18.w,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          // cubit.itemsNumber.toString(),
                                          cubit.cartMap[item.id].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        SizedBox(width: 4.w),
                                        IconButton(
                                          style: IconButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              disabledForegroundColor:
                                                  Colors.white,
                                              disabledBackgroundColor:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.8),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.8)),
                                          color: Colors.white,
                                          onPressed: state
                                                  is ChangeQuantityInCartLoading
                                              ? null
                                              : () {
                                                  cubit.changeQuantity(
                                                      itemId: item.id,
                                                      quantity: (cubit.cartMap[
                                                              item.id]! +
                                                          1));
                                                },
                                          icon: Icon(
                                            Iconsax.add_copy,
                                            size: 18.w,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          cubit.cartMap[item.id]! == 1
                                              ? '${item.product.price.toStringAsFixed(1)}\$'
                                              : '${(item.product.price * cubit.cartMap[item.id]!).toStringAsFixed(1)}\$',
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        // SizedBox(width: 4.w),
                                        // IconButton(
                                        //   style: IconButton.styleFrom(
                                        //       backgroundColor: Theme.of(context)
                                        //           .colorScheme
                                        //           .error),
                                        //   color: Theme.of(context)
                                        //       .colorScheme
                                        //       .onError,
                                        //   onPressed: () {
                                        //     buildDialogue(
                                        //       context: context,
                                        //       title: 'Remove Product',
                                        //       message:
                                        //           'Are you sure you want to remove this Item?',
                                        //       onDelete: () {
                                        //         cubit.removeItem(item.id);
                                        //         Navigator.of(context).pop();
                                        //       },
                                        //     );
                                        //     // cubit.removeItem(item.id);
                                        //   },
                                        //   icon: const Icon(
                                        //     Iconsax.shop_remove_copy,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
