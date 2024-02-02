import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/controller/favorites/favorites_cubit.dart';
import '/controller/favorites/favorites_states.dart';
import '/shared/components/vertical_divider.dart';

class BuildUserInfoCard extends StatelessWidget {
  const BuildUserInfoCard({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    final locale = AppLocalizations.of(context)!;
    return Card(
      color: isDark ? AppColors.blackColor : Colors.white,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isDark ? AppColors.blackColor : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  locale.orders,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<CartCubit, CartStates>(
                  builder: (context, state) {
                    return Text(
                      CartCubit.get(context).ordersModel != null
                          ? '${CartCubit.get(context).ordersModel!.data.orders.length} ${locale.orders}'
                          : '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color:
                                isDark ? Colors.grey : const Color(0xFF747474),
                          ),
                    );
                  },
                ),
              ],
            ),
            BuildVerticalDivider(
              height: 45.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  locale.wishlist,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<FavoritesCubit, FavoritesStates>(
                  builder: (context, state) {
                    return Text(
                      FavoritesCubit.get(context).favoritesModel != null
                          ? '${FavoritesCubit.get(context).favoritesModel!.data.length} ${locale.item}'
                          : '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color:
                                isDark ? Colors.grey : const Color(0xFF747474),
                          ),
                    );
                  },
                ),
              ],
            ),
            BuildVerticalDivider(
              height: 45.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  locale.in_cart,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                BlocBuilder<CartCubit, CartStates>(builder: (context, state) {
                  return Text(
                    CartCubit.get(context).cartModel != null
                        ? '${CartCubit.get(context).cartModel?.data.cartItems.length}  ${locale.item}'
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark ? Colors.grey : const Color(0xFF747474),
                        ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
