import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/controller/settings/settings_cubit.dart';
import 'package:shop_app/controller/settings/settings_states.dart';
import 'package:shop_app/shared/components/row_like_appbar.dart';
import 'package:shop_app/shared/components/toast_message.dart';

import '../../shared/components/default_button_in_app.dart';
import '../../shared/components/default_text_form_in_app.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String oldPassword = '';
    String enteredPassword = '';
    TextTheme font = Theme.of(context).textTheme;

    final locale = AppLocalizations.of(context)!;
    double w = MediaQuery.sizeOf(context).width;

    var formKey = GlobalKey<FormState>();
    // var passwordController = TextEditingController();
    // var confirmPasswordController = TextEditingController();
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {
        if (state is UpdateUserPasswordFailureState) {
          buildToastMessage(
            message: state.errorMessage,
            gravity: ToastGravity.CENTER,
            textColor: Theme.of(context).colorScheme.onSecondary,
            background:
                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          );
        }
        if (state is UpdateUserPasswordSuccessState) {
          buildToastMessage(
            message: locale.success_password_update,
            gravity: ToastGravity.CENTER,
            textColor: Theme.of(context).colorScheme.onSecondary,
            background:
                Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<SettingsCubit>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 23.h, left: w / 25, right: w / 25),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildRowLikeAppBar(text: locale.change_password),
                      SizedBox(
                        height: 60.h,
                      ),
                      Text(
                        locale.enter_new_password,
                        style: font.bodyLarge!.copyWith(fontSize: 18.sp),
                      ),
                      Text(
                        locale.make_sure,
                        style: font.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BuildDefaultTextField(
                        withText: true,
                        aboveFieldText: locale.old_password,
                        withEyeVisible: true,
                        backGroundColor: Colors.white,
                        maxLength: 20,
                        inputType: TextInputType.visiblePassword,
                        hintText: '***********',
                        onValidate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the old password';
                          } else if (value.length < 6) {
                            return 'please enter a stronger password';
                          }
                          return null;
                        },
                        context: context,
                        width: double.infinity,
                        height: 50,
                        maxLines: 1,
                        isObscured: cubit.isObscured,
                        suffixIcon: cubit.isObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onSuffixTaped: cubit.changePasswordVisibility,
                        onSaved: (value) {
                          oldPassword = value!;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BuildDefaultTextField(
                        onSubmitted: (_) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            cubit.updateUserPassword(
                              oldPassword: oldPassword,
                              newPassword: enteredPassword,
                            );
                          }
                        },
                        withEyeVisible: true,
                        backGroundColor: Colors.white,
                        aboveFieldText: locale.new_password,
                        context: context,
                        width: double.infinity,
                        height: 50,
                        maxLines: 1,
                        isObscured: cubit.isNewObscured,
                        suffixIcon: cubit.isNewObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        onSuffixTaped: cubit.changeNewPasswordVisibility,
                        withText: true,
                        onValidate: (value) {
                          if (value!.isEmpty) {
                            return "please enter the new password";
                          } else if (value.length < 6) {
                            return 'please enter a stronger password';
                          }
                          // else if (passwordController.text !=
                          //     confirmPasswordController.text) {
                          //   return "كلمة المرور وتأكيد كلمة المرور غير متطابقين.";
                          // }
                          return null;
                        },
                        inputType: TextInputType.text,
                        hintText: '***********',
                        maxLength: 30,
                        onSaved: (value) {
                          enteredPassword = value!;
                        },
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      state is UpdateUserPasswordLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : BuildDefaultButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  cubit.updateUserPassword(
                                    oldPassword: oldPassword,
                                    newPassword: enteredPassword,
                                  );
                                }
                              },
                              text: locale.save,
                              elevation: 2,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
