import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../controller/authentication/authentication_cubit.dart';
import '../../controller/authentication/authentication_states.dart';
import '../../shared/components/default_button_in_app.dart';
import '../../shared/components/default_text_form_in_app.dart';
import '../../shared/components/toast_message.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '/modules/login/login_screen.dart';
import '/shared/helper_functions.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    var enteredName = '';
    var enteredPhone = '';
    var enteredEmail = '';
    var enteredPassword = '';
    return BlocProvider(
      create: (ctx) => AuthenticationCubit(),
      child: Scaffold(
        // appBar: AppBar(
        //   leading: const BuildBackButton(
        //     hasBackground: false,
        //   ),
        // ),
        body: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
          listener: (context, state) {
            if (state is AuthenticationRegisterErrorState) {
              buildToastMessage(
                message: state.error,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                background: Colors.red,
              );
            }
            if (state is AuthenticationRegisterSuccessState) {
              if (state.model.data != null || state.model.data!.token != null) {
                CacheHelper.saveData(
                    key: AppConstants.userName, value: state.model.data!.name);
                CacheHelper.saveData(
                    key: AppConstants.userEmail,
                    value: state.model.data!.email);
                CacheHelper.saveData(
                    key: AppConstants.userPhone,
                    value: state.model.data!.phone);
                CacheHelper.saveData(
                    key: AppConstants.token, value: state.model.data!.token);
                // CacheHelper.saveData(
                //     key: 'id', value: state.model.data!.id.toString());

                print(state.model.data!.token);
                HelperFunctions.pussAndRemoveAll(
                  context,
                  const LoginScreen(),
                );
              }
            }
          },
          builder: (context, state) {
            final cubit = AuthenticationCubit.get(context);
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16.w),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.register,
                            style: const TextStyle().copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            locale.signup_welcome,
                            style: const TextStyle().copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          BuildDefaultTextField(
                            aboveFieldText: locale.full_name,
                            inputType: TextInputType.name,
                            hintText: 'Ahmed Zaid',
                            backGroundColor: Colors.white,
                            context: context,
                            width: double.infinity,
                            height: 50,
                            maxLength: 40,
                            isObscured: false,
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your full name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredName = value!;
                            },
                          ),
                          SizedBox(height: 12.h),
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
                          SizedBox(height: 8.h),
                          BuildDefaultTextField(
                            aboveFieldText: locale.phone,
                            inputType: TextInputType.number,
                            hintText: '012343553',
                            backGroundColor: Colors.white,
                            context: context,
                            width: double.infinity,
                            height: 50,
                            maxLength: 40,
                            isObscured: false,
                            onValidate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your phone number';
                              } else if (!RegExp(r'^(01)[0125]\d{8}$')
                                  .hasMatch(value)) {
                                return 'please enter a valid phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredPhone = value!;
                            },
                          ),
                          SizedBox(height: 8.h),
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
                                cubit.registerUser(
                                  name: enteredName,
                                  email: enteredEmail,
                                  phone: enteredPhone,
                                  password: enteredPassword,
                                );
                              }
                            },
                          ),
                          SizedBox(height: 24.h),
                          state is AuthenticationRegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : BuildDefaultButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      cubit.registerUser(
                                        name: enteredName,
                                        email: enteredEmail,
                                        phone: enteredPhone,
                                        password: enteredPassword,
                                      );
                                    }
                                  },
                                  text: locale.register,
                                  elevation: 2,
                                  context: context,
                                ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(locale.have_account),
                              // const SizedBox(
                              //   width: 2,
                              // ),
                              TextButton(
                                  onPressed: () {
                                    HelperFunctions.pussAndRemoveAll(
                                      context,
                                      const LoginScreen(),
                                    );
                                  },
                                  child: Text(locale.login))
                            ],
                          )
                        ],
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
