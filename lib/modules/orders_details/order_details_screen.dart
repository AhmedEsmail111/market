import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/back_button.dart';
import '../../shared/styles/colors.dart';
import '/controller/order_details/order_details_cubit.dart';
import '/controller/order_details/order_details_states.dart';
import '/modules/adresses/addresses_item.dart';
import '/shared/components/product_tile.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    final locale = AppLocalizations.of(context)!;
    print(orderId);
    return BlocProvider(
      create: (ctx) => OrderDetailsCubit()..getOrderDetails(orderId),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = OrderDetailsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(),
              title: Text(locale.order_summary),
            ),
            body: cubit.orderDetailsModel != null
                ? SingleChildScrollView(
                    child: ListView(
                      padding: EdgeInsets.all(16.w),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2)
                                  : AppColors.borderColor,
                            ),
                            color: isDark ? AppColors.blackColor : Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   'Details',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodyLarge!
                              //       .copyWith(fontSize: 22.sp),
                              // ),
                              // SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${locale.status} : ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    cubit.orderDetailsModel!.data.status,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${locale.date} : ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    cubit.orderDetailsModel!.data.date,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          // color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${locale.payment_method} : ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    cubit.orderDetailsModel!.data
                                                .paymentMethod ==
                                            'cash'
                                        ? 'Cash on Delivery'
                                        : 'Via Online',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          // color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Discount: ',
                              //       style:
                              //           Theme.of(context).textTheme.bodyLarge,
                              //     ),
                              //     Text(
                              //       '${cubit.orderDetailsModel!.data.discount}\$',
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodyMedium!
                              //           .copyWith(
                              //             fontWeight: FontWeight.w500,
                              //             // color: Theme.of(context).colorScheme.primary,
                              //           ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${locale.total} : ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    '${cubit.orderDetailsModel!.data.total.toStringAsFixed(2)}\$',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          // color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                locale.shipping_address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 22.sp),
                              ),

                              BuildAddressesItem(
                                  withColor: false,
                                  address:
                                      cubit.orderDetailsModel!.data.address),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          locale.products,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 22.sp),
                        ),
                        SizedBox(height: 8.h),
                        ListView.separated(
                          itemCount:
                              cubit.orderDetailsModel!.data.products.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => SizedBox(
                            height: 8.h,
                          ),
                          itemBuilder: (context, index) => BuildProductTile(
                            withFav: false,
                            product:
                                cubit.orderDetailsModel!.data.products[index],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        },
      ),
    );
  }
}
