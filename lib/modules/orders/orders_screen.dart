import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/build_dialogue.dart';
import '../../shared/components/loading_container.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/modules/orders/order_tile.dart';
import '/modules/orders_details/order_details_screen.dart';
import '/shared/components/back_button.dart';
import '/shared/helper_functions.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: const BuildBackButton(),
                title: Text(locale.my_orders),
              ),
              body: Column(
                children: [
                  cubit.ordersModel != null
                      ? Expanded(
                          child: ListView.separated(
                            // physics: const NeverScrollableScrollPhysics(),
                            // shrinkWrap: true,

                            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                            itemCount: cubit.ordersModel!.data.orders.length,
                            itemBuilder: (ctx, index) => BuildOrderTile(
                              order: cubit.ordersModel!.data.orders[index],
                              onCancel: () {
                                buildDialogue(
                                  context: context,
                                  message: locale.cancel_message,
                                  title: locale.cancel_order,
                                  doText: locale.cancel,
                                  undoText: locale.keep,
                                  onDelete: () {
                                    cubit.cancelOrder(
                                      cubit.ordersModel!.data.orders[index].id,
                                      index,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              onTap: () {
                                HelperFunctions.pushScreen(
                                  context,
                                  OrderDetailsScreen(
                                    orderId: cubit
                                        .ordersModel!.data.orders[index].id,
                                  ),
                                );
                              },
                            ),
                            separatorBuilder: (ctx, index) =>
                                SizedBox(height: 8.h),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  if (cubit.ordersModel != null &&
                      cubit.ordersModel!.data.orders.isEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Text(
                          locale.nothing_in_orders,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (cubit.isCancellingOrder) const BuildLoadingContainer()
          ],
        );
      },
    );
  }
}
