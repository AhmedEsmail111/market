import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/shared/components/toast_message.dart';

class BuildAddToCart extends StatelessWidget {
  final int id;
  const BuildAddToCart({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<CartCubit, CartStates>(listener: (context, state) {
      // show a toast message when the user add or remove the item from the cart
      if (state is ToggleProductInCartSuccess) {
        buildToastMessage(
          message: state.successMessage,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          background: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        );
      }
    }, builder: (context, state) {
      final cubit = CartCubit.get(context);
      return Row(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: cubit.isAddRemoveDone
                ? TextButton.icon(
                    onPressed: () {
                      // adds or removes an item from the cart
                      cubit.addOrRemoveFromCart(id);
                    },
                    icon: Icon(
                        cubit.cartItems.contains(id)
                            ? Iconsax.shop_remove
                            : Iconsax.shop_add,
                        color: Theme.of(context).colorScheme.onPrimary),
                    label: Text(
                      cubit.cartItems.contains(id)
                          ? locale.remove_cart
                          : locale.add_cart,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                // cubit.itemsNumber != 0
                                //     ?
                                Theme.of(context).colorScheme.onPrimary,
                            // : Colors.black,
                          ),
                    ),
                  )
                : SizedBox(
                    width: 80.w,
                    child: const Center(
                      child: LinearProgressIndicator(),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}
