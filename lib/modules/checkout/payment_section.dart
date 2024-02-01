import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/modules/checkout/payment_item.dart';

class BuildPaymentSection extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const BuildPaymentSection({super.key, required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        darKBackground;
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CartCubit.get(context);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.payment_method,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    scaffoldKey.currentState!.showBottomSheet(
                      (context) => Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.grey.shade500
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        height: 300.h,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.h, bottom: 16.h),
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
                            Expanded(
                              child: ListView.separated(
                                itemCount: cubit.payments.length,
                                itemBuilder: ((context, index) {
                                  return BuildPaymentItem(
                                    chosenIndex: cubit.chosenPaymentIndex,
                                    currentIndex: index,
                                    onTap: () {
                                      cubit.changePayment(index);
                                      Navigator.pop(context);
                                    },
                                    image: cubit.payments[index].image,
                                    name: cubit.payments[index].name,
                                  );
                                }),
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 8.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    locale.change,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.deepPurpleAccent
                              : Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            BuildPaymentItem(
              image: cubit.payments[cubit.chosenPaymentIndex].image,
              name: cubit.payments[cubit.chosenPaymentIndex].name,
              chosenIndex: cubit.chosenPaymentIndex,
              currentIndex: cubit.chosenPaymentIndex,
            )
          ],
        );
      },
    );
  }
}
