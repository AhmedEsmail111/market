import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../models/addresses/addresses_model.dart';
import '../../shared/components/back_button.dart';
import '../../shared/components/default_button_in_app.dart';
import '../../shared/components/toast_message.dart';
import '../../shared/styles/colors.dart';
import '/controller/addresses/addresses_cubit.dart';
import '/controller/addresses/addresses_states.dart';
import '/shared/components/default_text_form_in_app.dart';

class AddNewAddressScreen extends StatelessWidget {
  final Address? address;
  const AddNewAddressScreen({super.key, this.address});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).bottomNavigationBarTheme.backgroundColor ==
        AppColors.darKBackground;
    final locale = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    var enteredName = '';
    var enteredPhone = '';
    var enteredCity = '';
    var enteredDetails = '';
    var enteredRegion = '';
    var enteredNotes = '';
    return BlocConsumer<AddressesCubit, AddressesStates>(
        listener: (context, state) {
      if (state is AddAddressSuccessState) {
        buildToastMessage(
          message: locale.success_address,
          gravity: ToastGravity.CENTER,
          textColor: Theme.of(context).colorScheme.onSecondary,
          background: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        );
        Navigator.pop(context);
      }
      if (state is UpdateAddressSuccessState) {
        buildToastMessage(
          message: locale.update_address,
          gravity: ToastGravity.CENTER,
          textColor: Theme.of(context).colorScheme.onSecondary,
          background: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        );
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      final cubit = AddressesCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          leading: const BuildBackButton(),
          title: Text(locale.add_address),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            Form(
                key: formKey,
                child: Column(
                  children: [
                    BuildDefaultTextField(
                      initialFieldValue: address != null ? address!.name : "",
                      prefixIcon: const Icon(
                        Iconsax.user_copy,
                      ),
                      withText: true,
                      aboveFieldText: locale.name,
                      inputType: TextInputType.text,
                      backGroundColor: Colors.white,
                      context: context,
                      width: double.infinity,
                      height: 50.h,
                      maxLength: 70,
                      isObscured: false,
                      hintText: 'ahmed',
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredName = value!;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BuildDefaultTextField(
                      initialFieldValue: address != null
                          ? '0${address!.phone.toStringAsFixed(0)}'
                          : "",
                      prefixIcon: const Icon(
                        Iconsax.mobile_copy,
                      ),
                      withText: true,
                      aboveFieldText: locale.phone,
                      backGroundColor: Colors.white,
                      maxLength: 16,
                      inputType: TextInputType.number,
                      maxLines: 1,
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter phone number';
                        } else if (!RegExp(r'^(01)[0125]\d{8}$')
                            .hasMatch(value)) {
                          return 'please enter a valid phone number';
                        }
                        return null;
                      },
                      hintText: '01234333455',
                      context: context,
                      width: double.infinity,
                      height: 50.h,
                      isObscured: false,
                      onSaved: (value) {
                        enteredPhone = value!;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BuildDefaultTextField(
                      initialFieldValue: address != null ? address!.city : "",
                      prefixIcon: const Icon(
                        Icons.place_outlined,
                      ),
                      withText: true,
                      aboveFieldText: locale.city,
                      inputType: TextInputType.text,
                      backGroundColor: Colors.white,
                      context: context,
                      width: double.infinity,
                      height: 50,
                      maxLength: 70,
                      isObscured: false,
                      hintText: 'cairo',
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter city';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredCity = value!;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BuildDefaultTextField(
                      initialFieldValue: address != null ? address!.region : "",
                      prefixIcon: const Icon(
                        Iconsax.map_1_copy,
                      ),
                      withText: true,
                      aboveFieldText: locale.region,
                      inputType: TextInputType.text,
                      backGroundColor: Colors.white,
                      context: context,
                      width: double.infinity,
                      height: 50,
                      maxLength: 70,
                      isObscured: false,
                      hintText: 'nas city',
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter region';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredRegion = value!;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BuildDefaultTextField(
                      initialFieldValue:
                          address != null ? address!.details : "",
                      prefixIcon: const Icon(
                        Iconsax.information_copy,
                      ),
                      withText: true,
                      aboveFieldText: locale.details,
                      inputType: TextInputType.text,
                      backGroundColor: Colors.white,
                      context: context,
                      width: double.infinity,
                      maxLines: 2,
                      height: 50,
                      maxLength: 150,
                      isObscured: false,
                      hintText:
                          'salah Eldeen Street - block 15 - apartment six',
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter address details';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredDetails = value!;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    BuildDefaultTextField(
                      initialFieldValue: address != null &&
                              address!.notes != null &&
                              address!.notes!.trim().isNotEmpty
                          ? address!.notes
                          : "",
                      prefixIcon: const Icon(
                        Iconsax.note_1_copy,
                      ),
                      withText: true,
                      aboveFieldText: locale.notes,
                      inputType: TextInputType.text,
                      backGroundColor: Colors.white,
                      context: context,
                      width: double.infinity,
                      height: 50,
                      maxLength: 70,
                      isObscured: false,
                      hintText: 'work address',
                      // onValidate: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'please enter notes';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        if (value != null) {
                          enteredNotes = value;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    cubit.isAddingAddress
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : BuildDefaultButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                // print(enteredName);
                                // print(enteredPhone);
                                // print(enteredNotes);
                                // print(enteredCity);
                                // print(enteredRegion);
                                if (address != null) {
                                  cubit.updateAddress(
                                      name: enteredName,
                                      region: enteredRegion,
                                      phone: enteredPhone,
                                      details: enteredDetails,
                                      city: enteredCity,
                                      notes: enteredNotes,
                                      addressId: address!.id);
                                } else {
                                  cubit.addAddress(
                                    name: enteredName,
                                    region: enteredRegion,
                                    phone: enteredPhone,
                                    details: enteredDetails,
                                    city: enteredCity,
                                    notes: enteredNotes,
                                  );
                                }
                              }
                            },
                            text: address != null
                                ? locale.save_changes
                                : locale.submit,
                            elevation: 3,
                            context: context,
                          ),
                  ],
                ))
          ],
        ),
      );
    });
  }
}
