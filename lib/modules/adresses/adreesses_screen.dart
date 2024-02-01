import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shop_app/controller/addresses/addresses_cubit.dart';
import 'package:shop_app/controller/addresses/addresses_states.dart';
import 'package:shop_app/modules/adresses/add_address.dart';
import 'package:shop_app/modules/adresses/addresses_item.dart';
import 'package:shop_app/shared/components/back_button.dart';
import 'package:shop_app/shared/helper_functions.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<AddressesCubit, AddressesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AddressesCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: const BuildBackButton(),
              title: Text(locale.addresses),
            ),
            body: cubit.addressesModel != null
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (ctx, index) => BuildAddressesItem(
                          address: cubit.addressesModel!.data[index],
                          onLongPress: () {
                            cubit.changeAddressId(
                                cubit.addressesModel!.data[index].id);
                          },
                          onTap: () {
                            HelperFunctions.pushScreen(
                                context,
                                AddNewAddressScreen(
                                  address: cubit.addressesModel!.data[index],
                                ));
                          },
                        ),
                    separatorBuilder: (_, __) => SizedBox(
                          height: 12.h,
                        ),
                    itemCount: cubit.addressesModel!.data.length)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                HelperFunctions.pushScreen(
                    context, const AddNewAddressScreen());
              },
              child: const Icon(Iconsax.add_copy),
            ),
          );
        });
  }
}
