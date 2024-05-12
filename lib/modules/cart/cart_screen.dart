import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/components/back_button.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/modules/cart/cart_item.dart';
import '/modules/checkout/checkout_screen.dart';
import '/shared/components/default_button_in_app.dart';
import '/shared/components/loading_container.dart';
import '/shared/components/toast_message.dart';
import '/shared/helper_functions.dart';

class CartScreen extends StatelessWidget {
  final bool withAppBar;
  const CartScreen({super.key, this.withAppBar = false});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        // show a toast message if the the item was removed from the database
        if (state is RemoveItemInCartSuccess) {
          buildToastMessage(
            message: locale.success_delete,
            gravity: ToastGravity.BOTTOM,
            textColor: Theme.of(context).colorScheme.onSecondary,
            background:
                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          );
        }
      },
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return Stack(
          children: [
            Scaffold(
              appBar: withAppBar
                  ? AppBar(
                      leading: const BuildBackButton(hasBackground: false),
                      title: Text(locale.my_cart),
                    )
                  : null,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    if (cubit.cartModel != null)
                      ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.w),
                        itemCount: cubit.cartModel!.data.cartItems.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => SizedBox(
                          height: 8.h,
                        ),
                        itemBuilder: (context, index) => BuildCartItem(
                          item: cubit.cartModel!.data.cartItems[index],
                        ),
                      ),
                    if (cubit.cartModel != null &&
                        cubit.cartModel!.data.cartItems.isEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              locale.nothing_in_cart,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    if (cubit.cartModel == null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
              bottomNavigationBar:
                  // show it only if the cartModel is not null and is not empty
                  cubit.cartModel != null &&
                          cubit.cartModel!.data.cartItems.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: BuildDefaultButton(
                            context: context,
                            onTap: () {
                              HelperFunctions.pushScreen(
                                  context, const CheckoutScreen());
                            },
                            text: cubit.cartModel != null
                                ? '${locale.checkout} ${cubit.getTotal(cubit.cartModel!.data.cartItems).toStringAsFixed(1)}\$'
                                : locale.checkout,
                            elevation: 4,
                          ),
                        )
                      : null,
            ),
            // paint an overly on the screen in case we are removing an item from the database
            if (cubit.isRemoving) const BuildLoadingContainer()
          ],
        );
      },
    );
  }
}
