import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/new_password/enter_new_password_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/helper_functions.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';

import '../../shared/components/default_button_in_app.dart';
import '../../shared/components/default_text_form_in_app.dart';
import '../../shared/components/row_like_appbar.dart';
import '/controller/settings/settings_cubit.dart';
import '/controller/settings/settings_states.dart';
import '/shared/components/toast_message.dart';

final formKey = GlobalKey<FormState>();

class ModifyProfileScreen extends StatelessWidget {
  const ModifyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    // print(CacheHelper.getData(key: AppConstant.userGender));
    // print(SettingsCubit.get(context).userModel!.data!.id);
    // final locale = AppLocalizations.of(context);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    String enteredName = '';
    String enteredEmail = '';
    String enteredPhone = '';

    String enteredPassword = '';
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {
        if (state is UpdateUserFailureState) {
          buildToastMessage(
            message: state.errorMessage,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            background:
                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          );
        }

        if (state is UpdateUserSuccessState) {
          buildToastMessage(
            message: 'updated successfully',
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            background:
                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          );
        }
      },
      builder: (context, state) {
        final settingsCubit = SettingsCubit.get(context);
        return Scaffold(
            body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  BuildRowLikeAppBar(
                    // color: Theme.of(context).colorScheme.inversePrimary,
                    text: locale.personal_profile,
                  ),
                  CircleAvatar(
                    radius: 40.w,
                    child: Icon(
                      Icons.person,
                      size: 35.w,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        BuildDefaultTextField(
                          withText: true,
                          aboveFieldText: locale.new_name,
                          initialFieldValue: settingsCubit.userModel != null
                              ? settingsCubit.userModel!.data!.name
                              : CacheHelper.getData(key: AppConstants.userName),
                          inputType: TextInputType.text,
                          backGroundColor: Colors.white,
                          context: context,
                          width: double.infinity,
                          height: 50.h,
                          maxLength: 70,
                          isObscured: false,
                          hintText: '',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredName = value!;
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        BuildDefaultTextField(
                          withText: true,
                          aboveFieldText: locale.new_email,
                          initialFieldValue: settingsCubit.userModel != null
                              ? settingsCubit.userModel!.data!.email
                              : CacheHelper.getData(
                                  key: AppConstants.userEmail),
                          inputType: TextInputType.text,
                          backGroundColor: Colors.white,
                          context: context,
                          width: double.infinity,
                          height: 50,
                          maxLength: 70,
                          isObscured: false,
                          hintText: 'ahmed@gmail.com',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                .hasMatch(value)) {
                              return 'The email is not valid';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredEmail = value!;
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        BuildDefaultTextField(
                          withText: true,
                          aboveFieldText: locale.new_phone,
                          initialFieldValue: settingsCubit.userModel != null
                              ? settingsCubit.userModel!.data!.phone
                              : CacheHelper.getData(
                                  key: AppConstants.userPhone),
                          backGroundColor: Colors.white,
                          maxLength: 16,
                          inputType: TextInputType.number,
                          maxLines: 1,
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your new phone number';
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
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        // BuildDefaultTextField(
                        //   withText: true,
                        //   aboveFieldText: locale.new_password,
                        //   withEyeVisible: true,
                        //   backGroundColor: Colors.white,
                        //   maxLength: 20,
                        //   inputType: TextInputType.visiblePassword,
                        //   hintText: '***********',
                        //   onValidate: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'please enter password';
                        //     } else if (value.length < 6) {
                        //       return 'please enter a stronger password';
                        //     }
                        //     return null;
                        //   },
                        //   context: context,
                        //   width: double.infinity,
                        //   height: 50,
                        //   maxLines: 1,
                        //   isObscured: settingsCubit.isObscured,
                        //   suffixIcon: settingsCubit.isObscured
                        //       ? Icons.visibility_off_outlined
                        //       : Icons.visibility_outlined,
                        //   onSuffixTaped: settingsCubit.changePasswordVisibility,
                        //   onSaved: (value) {
                        //     enteredPassword = value!;
                        //   },
                        // ),
                        SizedBox(
                          height: 50.h,
                        ),
                        state is UpdateUserLoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : BuildDefaultButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();

                                    print(enteredName);
                                    print(enteredEmail);
                                    print(enteredPhone);
                                    print(enteredPassword);
                                    settingsCubit.updateUser(
                                      name: enteredName,
                                      email: enteredEmail,
                                      password: enteredPassword,
                                      phone: enteredPhone,
                                    );
                                  }
                                },
                                text: locale.save_changes,
                                elevation: 3,
                                context: context,
                              ),

                        SizedBox(height: 16.h),
                        TextButton(
                            onPressed: () {
                              HelperFunctions.pushScreen(
                                  context, const NewPasswordScreen());
                            },
                            child: Text(
                              locale.change_password,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.8)),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
