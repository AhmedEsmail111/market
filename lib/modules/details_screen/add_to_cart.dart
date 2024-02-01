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
          // IconButton(
          //   style: IconButton.styleFrom(
          //       backgroundColor: Theme.of(context)
          //           .colorScheme
          //           .secondary
          //           .withOpacity(0.5)),
          //   color: Colors.white,
          //   onPressed: () {
          //     cubit.decrement();
          //   },
          //   icon: const Icon(Iconsax.minus_square),
          // ),
          // SizedBox(width: 4.w),
          // Text(
          //   cubit.itemsNumber.toString(),
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          // SizedBox(width: 4.w),
          // IconButton(
          //   style: IconButton.styleFrom(
          //       backgroundColor:
          //           Theme.of(context).colorScheme.primary.withOpacity(0.8)),
          //   color: Colors.white,
          //   onPressed: () {
          //     cubit.increment();
          //   },
          //   icon: const Icon(Iconsax.add_square),
          // ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ),
              color:
                  //  cubit.itemsNumber == 0
                  //     ? Theme.of(context)
                  //         .colorScheme
                  //         .secondary
                  //         .withOpacity(0.15)
                  //     :
                  Theme.of(context).colorScheme.primary,
            ),
            child: cubit.isAddRemoveDone
                ? TextButton.icon(
                    onPressed: () {
                      cubit.addOrRemoveFromCart(id).then((value) {
                        print(cubit.cartItems.contains(id));
                        print(cubit.cartItems.length);
                      });
                    },
                    icon: Icon(
                        cubit.cartItems.contains(id)
                            ? Iconsax.shop_remove
                            : Iconsax.shop_add,
                        color:
                            // cubit.itemsNumber != 0
                            //     ?
                            Theme.of(context).colorScheme.onPrimary
                        // : null,
                        ),
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
