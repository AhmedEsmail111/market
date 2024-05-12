import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/styles/colors.dart';
import '/controller/addresses/addresses_cubit.dart';
import '/controller/addresses/addresses_states.dart';
import '/modules/adresses/add_address.dart';
import '/modules/adresses/addresses_item.dart';
import '/shared/components/default_button_in_app.dart';
import '/shared/helper_functions.dart';

class BuildAddressSection extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const BuildAddressSection({super.key, required this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<AddressesCubit, AddressesStates>(
      builder: (context, state) {
        final cubit = AddressesCubit.get(context);
        print(cubit.addressesModel!.data.length);
        print(cubit.chosenAddressId);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.shipping_address,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () {
                    scaffoldKey.currentState!.showBottomSheet(
                      // a modal bottom shhet for the user to choose an address from  or if he wants to change the chosen one
                      (context) => Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.grey.shade400
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
                                itemCount:
                                    cubit.addressesModel!.data.length + 1,
                                itemBuilder: ((context, index) {
                                  // add a button at the end of the list if the user wanna add a new address
                                  if (index ==
                                      cubit.addressesModel!.data.length) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 16.h),
                                      child: BuildDefaultButton(
                                          onTap: () {
                                            HelperFunctions.pushScreen(context,
                                                const AddNewAddressScreen());
                                          },
                                          text: 'Add New Address',
                                          elevation: 1,
                                          context: context),
                                    );
                                  }
                                  return BuildAddressesItem(
                                    onTap: () {
                                      // change the chosen address id to be able to show to the user the address he has just chosen
                                      cubit.changeAddressId(
                                          cubit.addressesModel!.data[index].id);
                                      Navigator.pop(context);
                                    },
                                    address: cubit.addressesModel!.data[index],
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
            // only if we have a chosen address id and the address model is not null, we show the user shipping address
            cubit.chosenAddressId != null &&
                    cubit.addressesModel != null &&
                    cubit.addressesModel!.data.isNotEmpty
                ? BuildAddressesItem(
                    withColor: false,
                    address: cubit.addressesModel!.data.firstWhere(
                        (element) => element.id == cubit.chosenAddressId))
                : const Text('Select Address'),
          ],
        );
      },
    );
  }
}
