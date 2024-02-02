import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shop_app/controller/addresses/addresses_cubit.dart';

import '/controller/cart/cart_cubit.dart';
import '/controller/favorites/favorites_cubit.dart';
import '/controller/home/home_cubit.dart';
import '/controller/home/home_states.dart';
import '/modules/search/search_screen.dart';
import '/shared/constants/constants.dart';
import '/shared/helper_functions.dart';
import '/shared/network/local/shared_preference.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    // Future.delayed(Duration(seconds: 2)).then((value) {
    //   FavoritesCubit.get(context).initFavorites();
    //   print('initFavorites in shop layout');
    // });
    FavoritesCubit.get(context).getFavorites();
    AddressesCubit.get(context).getAddresses();
    CartCubit.get(context).getCart();

    print(CacheHelper.getData(key: AppConstants.token));
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return PopScope(
          onPopInvoked: (_) {
            cubit.changeBottomNavBarIndex(0);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(locale.app_name),
              actions: [
                IconButton(
                  onPressed: () {
                    HelperFunctions.pushScreen(context, const SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    size: 25.w,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBarIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.home_copy),
                  label: locale.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.heart_copy),
                  label: locale.wishlist,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.shopping_cart_copy),
                  label: locale.cart,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Iconsax.setting_3_copy),
                  label: locale.settings,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
