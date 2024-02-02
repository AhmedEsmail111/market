import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/controller/authentication/authentication_cubit.dart';
import '/controller/authentication/authentication_states.dart';
import '/layout/shop_layout.dart';
import '/modules/register/register_screen.dart';
import '/shared/components/default_button_in_app.dart';
import '/shared/components/default_text_form_in_app.dart';
import '/shared/components/toast_message.dart';
import '/shared/constants/constants.dart';
import '/shared/helper_functions.dart';
import '/shared/network/local/shared_preference.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    // print(CacheHelper.getData(key: isBoarding));
    final formKey = GlobalKey<FormState>();

    var enteredEmail = '';
    var enteredPassword = '';
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: Scaffold(
        // appBar: AppBar(),
        body: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
          listener: (context, state) {
            if (state is AuthenticationLoginErrorState) {
              buildToastMessage(
                message: state.error,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white,
                background: Colors.red,
              );
            }
            if (state is AuthenticationLoginSuccessState) {
              if (state.model.data != null || state.model.data!.token != null) {
                CacheHelper.saveData(
                    key: AppConstants.userName, value: state.model.data!.name);
                CacheHelper.saveData(
                    key: AppConstants.userEmail,
                    value: state.model.data!.email);
                CacheHelper.saveData(
                    key: AppConstants.userPhone,
                    value: state.model.data!.phone);
                // CacheHelper.saveData(
                //     key: userEmail, value: );
                CacheHelper.saveData(
                    key: AppConstants.token, value: state.model.data!.token);
                // CacheHelper.saveData(
                //     key: 'id', value: state.model.data!.id.toString());

                HelperFunctions.pussAndRemoveAll(
                  context,
                  const ShopLayout(),
                );
              }
            }
          },
          builder: (context, state) {
            final cubit = AuthenticationCubit.get(context);
            return SafeArea(
              child: Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 35.h, right: 16.w, left: 16.w, bottom: 16.h),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                locale.welcome,
                                style: const TextStyle().copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 8.5,
                            ),
                            Text(
                              locale.login,
                              style: const TextStyle().copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              locale.login_welcome,
                              style: const TextStyle().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 16),
                            BuildDefaultTextField(
                              aboveFieldText: locale.email,
                              inputType: TextInputType.emailAddress,
                              hintText: 'ahmed@gmail.com',
                              backGroundColor: Colors.white,
                              context: context,
                              width: double.infinity,
                              height: 50,
                              maxLength: 40,
                              isObscured: false,
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your email address';
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
                            const SizedBox(height: 16),
                            BuildDefaultTextField(
                              aboveFieldText: locale.password,
                              inputType: TextInputType.visiblePassword,
                              hintText: '******',
                              backGroundColor: Colors.white,
                              context: context,
                              width: double.infinity,
                              height: 50,
                              maxLength: 40,
                              isObscured: cubit.isObscured,
                              suffixIcon: cubit.isObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              withEyeVisible: true,
                              onSuffixTaped: cubit.changePasswordVisibility,
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your password';
                                } else if (value.length < 6) {
                                  return 'password should be t least 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                enteredPassword = value!;
                              },
                              onSubmitted: (_) {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  cubit.loginUser(
                                    email: enteredEmail,
                                    password: enteredPassword,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            state is AuthenticationLoginLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : BuildDefaultButton(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        cubit.loginUser(
                                          email: enteredEmail,
                                          password: enteredPassword,
                                        );
                                      }
                                    },
                                    text: locale.login,
                                    elevation: 2,
                                    context: context,
                                  ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(locale.have_no_account),
                                // const SizedBox(
                                //   width: 2,
                                // ),
                                TextButton(
                                    onPressed: () {
                                      HelperFunctions.pushScreen(
                                        context,
                                        const RegisterScreen(),
                                      );
                                    },
                                    child: Text(locale.register))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
