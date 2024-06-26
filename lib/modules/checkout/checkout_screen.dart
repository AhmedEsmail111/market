import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/components/toast_message.dart';
import '../../shared/styles/colors.dart';
import '../cart/cart_item.dart';
import '/controller/addresses/addresses_cubit.dart';
import '/controller/addresses/addresses_states.dart';
import '/controller/cart/cart_cubit.dart';
import '/controller/cart/cart_states.dart';
import '/modules/checkout/address_section.dart';
import '/modules/checkout/billing_section.dart';
import '/modules/checkout/payment_section.dart';
import '/modules/success/success_screen.dart';
import '/shared/components/back_button.dart';
import '/shared/components/default_button_in_app.dart';
import '/shared/components/divider_line.dart';
import '/shared/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    final locale = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        // if the order was added successfully then go to the success page
        if (state is AddOrderSuccessState) {
          Navigator.pop(context);
          HelperFunctions.pushScreen(context, const SuccessScreen());
        }
        // if the promoCode entered is wrong then show a toast message
        if (state is ValidatePromoCodeFailure) {
          buildToastMessage(
              message: state.errorMessage,
              gravity: ToastGravity.BOTTOM,
              textColor: Theme.of(context).colorScheme.onError,
              background: Theme.of(context).colorScheme.error.withOpacity(0.9));
        }
      },
      builder: (context, state) {
        final cubit = CartCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: const BuildBackButton(),
            title: Text(locale.order_review),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    itemCount: cubit.cartModel!.data.cartItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => SizedBox(
                      height: 8.h,
                    ),
                    itemBuilder: (context, index) => BuildCartItem(
                      showActions: false,
                      item: cubit.cartModel!.data.cartItems[index],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.4)
                            : AppColors.borderColor,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Form(
                      key: formKey,
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                // validate only if there is a value
                                if (value.trim().isNotEmpty) {
                                  cubit.validatePromoCode(cubit.code);
                                }
                              },
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                // save only if there is a value
                                if (value != null) {
                                  cubit.changeCode(value.trim());
                                }
                              },
                              onChanged: (value) {
                                // save the value to toggle the the validate button status where enabled or disablem if the field is empty
                                cubit.changeCode(value.trim());
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: locale.have_a_promo,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 90.w,
                            child: state is ValidatePromoCodeLoading
                                ? const LinearProgressIndicator()
                                : BuildDefaultButton(
                                    onTap: cubit.code.trim().isNotEmpty
                                        ? () {
                                            cubit.validatePromoCode(cubit.code);
                                          }
                                        : null,
                                    text: locale.apply,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    elevation: 2,
                                    context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.4)
                            : AppColors.borderColor,
                      ),
                      color: isDark ? AppColors.blackColor : Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Column(
                      children: [
                        BuildBillingSection(
                          subTotal: cubit.cartModel!.data.total.toDouble(),
                        ),
                        SizedBox(height: 8.h),
                        const BuildDividerLine(),
                        BuildPaymentSection(scaffoldKey: scaffoldKey),
                        SizedBox(height: 8.h),
                        BuildAddressSection(
                          scaffoldKey: scaffoldKey,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  !cubit.isAddingOrder
                      ? BlocBuilder<AddressesCubit, AddressesStates>(
                          builder: (context, state) => BuildDefaultButton(
                            context: context,
                            onTap: () {
                              final addressCubit = AddressesCubit.get(context);
                              // if no address is hosen we ask the user to choose one
                              if (addressCubit.addressesModel == null ||
                                  addressCubit.chosenAddressId == null ||
                                  addressCubit.addressesModel!.data.isEmpty) {
                                buildToastMessage(
                                  message:
                                      'Please choose a shipping address to continue!',
                                  gravity: ToastGravity.CENTER,
                                  textColor:
                                      Theme.of(context).colorScheme.onError,
                                  background:
                                      Theme.of(context).colorScheme.error,
                                );
                                return;
                              }
                              // if he chose to pay cash the order will be added to the database and the he will be directed to the success page
                              // but if he chose online payment he will pay the order via stripe first and then the normal flow will continue
                              if (cubit.chosenPaymentIndex == 0) {
                                cubit.makePayment(
                                  (cubit.getTotal(
                                              cubit.cartModel!.data.cartItems) +
                                          69.7)
                                      .round(),
                                  'USD',
                                  context,
                                  paymentMethod:
                                      cubit.chosenPaymentIndex == 1 ? 1 : 2,
                                  addressId: addressCubit.chosenAddressId!,
                                );
                              } else {
                                cubit.addOrder(
                                  paymentMethod:
                                      cubit.chosenPaymentIndex == 1 ? 1 : 2,
                                  addressId: addressCubit.chosenAddressId!,
                                );
                              }
                            },
                            text:
                                '${locale.checkout} ${(cubit.getTotal(cubit.cartModel!.data.cartItems) + 69.7).toStringAsFixed(1)}\$',
                            elevation: 4,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
