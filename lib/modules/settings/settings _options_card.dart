// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shop_app/controller/language/language_cubit.dart';
import 'package:shop_app/controller/language/language_states.dart';
import 'package:shop_app/modules/change_language/change_language.dart';
import 'package:shop_app/modules/report_problem/report_problem_screen.dart';

import '../../shared/components/divider_line.dart';
import '../../shared/styles/colors.dart';
import '/modules/adresses/adreesses_screen.dart';
import '/modules/cart/cart_screen.dart';
import '/modules/modify_profile/modify_profile.dart';
import '/modules/orders/orders_screen.dart';
import '/modules/settings/settings_tile.dart';
import '/shared/helper_functions.dart';

class BuildSettingsOptionsCard extends StatelessWidget {
  const BuildSettingsOptionsCard({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    return Card(
      color: isDark ? blackColor : Colors.white,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isDark ? blackColor : Colors.white,
        ),
        child: Column(
          children: [
            BuildSettingsTile(
              icon: Iconsax.user_copy,
              text: locale.modify_profile,
              withSwitchIcon: false,
              iconColor: Theme.of(context).colorScheme.primary,
              onClick: () {
                HelperFunctions.pushScreen(
                  context,
                  const ModifyProfileScreen(),
                );
                // if (HelperFunctions.hasUserRegistered()) {
                //   Navigator.pushNamed(context, 'modifyProfile');
                // } else {
                //   buildToastMessage(
                //       message: locale.go_register_message,
                //       gravity: ToastGravity.CENTER);
                // }
              },
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: const BuildDividerLine(
            //     thickness: 2,
            //   ),
            // ),
            // BuildProfileTile(
            //   icon: SolarIconsOutline.heart,
            //   iconColor: const Color(0xFF747474),
            //   text: locale.favorite_adds,
            //   withSwitchIcon: false,
            //   onClick: () {
            //     if (HelperFunctions.hasUserRegistered()) {
            //       Navigator.pushNamed(context, 'favoriteAdds');
            //     } else {
            //       buildToastMessage(
            //           message: locale.go_register_message,
            //           gravity: ToastGravity.CENTER);
            //     }
            //   },
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: const BuildDividerLine(
            //     thickness: 2,
            //   ),
            // ),
            // BuildProfileTile(
            //   icon: Icons.l,
            //   iconColor: const Color(0xFF747474),
            //   text: locale.language,
            //   withSwitchIcon: false,
            //   onClick: () {
            //     Navigator.pushNamed(context, 'changeLanguage');
            //   },
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const BuildDividerLine(
                thickness: 2,
              ),
            ),

            BuildSettingsTile(
              icon: Iconsax.safe_home_copy,
              iconColor: Theme.of(context).colorScheme.primary,
              text: locale.my_addresses,
              withSwitchIcon: false,
              onClick: () {
                HelperFunctions.pushScreen(context, const AddressesScreen());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const BuildDividerLine(
                thickness: 2,
              ),
            ),

            BuildSettingsTile(
              icon: Iconsax.shopping_cart_copy,
              iconColor: Theme.of(context).colorScheme.primary,
              text: locale.my_cart,
              withSwitchIcon: false,
              onClick: () {
                HelperFunctions.pushScreen(
                  context,
                  const CartScreen(
                    withAppBar: true,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const BuildDividerLine(
                thickness: 2,
              ),
            ),

            BuildSettingsTile(
              icon: Iconsax.trade_copy,
              iconColor: Theme.of(context).colorScheme.primary,
              text: locale.my_orders,
              withSwitchIcon: false,
              onClick: () {
                HelperFunctions.pushScreen(context, const OrdersScreen());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const BuildDividerLine(
                thickness: 2,
              ),
            ),
            BuildSettingsTile(
              icon: Iconsax.language_square_copy,
              iconColor: Theme.of(context).colorScheme.primary,
              text: locale.language,
              withSwitchIcon: false,
              onClick: () {
                HelperFunctions.pushScreen(
                    context, const ChangeLanguageScreen());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const BuildDividerLine(
                thickness: 2,
              ),
            ),
            BlocBuilder<ShopCubit, ShopStates>(builder: (context, state) {
              final cubit = ShopCubit.get(context);
              return BuildSettingsTile(
                icon: Icons.brightness_4_outlined,
                iconColor: Theme.of(context).colorScheme.primary,
                text: locale.dark_mode,
                withSwitchIcon: true,
                switchStatus: cubit.isDark,
                onClick: cubit.setDarkMode,
              );
            }),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: const BuildDividerLine(
            //     thickness: 2,
            //   ),
            // ),
            // BuildSettingsTile(
            //   icon: Icons.help_outline_outlined,
            //   iconColor: Theme.of(context).colorScheme.primary,
            //   text: locale.help,
            //   withSwitchIcon: false,
            //   onClick: () {},
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const BuildDividerLine(
                thickness: 2,
              ),
            ),
            BuildSettingsTile(
              icon: Icons.report_gmailerrorred_outlined,
              iconColor: Theme.of(context).colorScheme.primary,
              text: locale.report_problem,
              withSwitchIcon: false,
              onClick: () {
                HelperFunctions.pushScreen(
                  context,
                  const ReportProblemScreen(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
