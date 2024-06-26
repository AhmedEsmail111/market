import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/settings/settings_states.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/shared/constants/api_constant.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';

import '../../modules/login/login_screen.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/remote/remote.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(InitialSettingsState());
  static SettingsCubit get(context) => BlocProvider.of(context);
// logout by removing the cached token and directing the user to the login page
  void logout(context) async {
    CacheHelper.removeData(key: AppConstants.token);
    CacheHelper.removeData(key: AppConstants.addressId);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ),
        (route) => false);
  }

  LoginModel? userModel;
// get the current user data
  void getUser() async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetProfileLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.getProfileEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        userModel = LoginModel.fromJson(response.data);

        print('${userModel!.data!.name} is the current user ');
        emit(GetProfileSuccessState());
      } else {
        emit(GetProfileFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetProfileFailureState());
    }
  }

// update the user information with new info
  void updateUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(UpdateUserLoadingState());

      final response = await DioHelper.putData(
        url: ApiConstants.updateProfileEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
        },
      );

      if (response.data['status'] == true) {
        userModel = LoginModel.fromJson(response.data);
        CacheHelper.saveData(
            key: AppConstants.userName, value: userModel!.data!.name);
        CacheHelper.saveData(
            key: AppConstants.userEmail, value: userModel!.data!.email);

        CacheHelper.saveData(
            key: AppConstants.userPhone, value: userModel!.data!.phone);

        print('${userModel!.data!.name} is the current user ');
        emit(UpdateUserSuccessState());
      } else {
        emit(UpdateUserFailureState(errorMessage: response.data['message']));
      }
    } catch (error) {
      print(error.toString());
      emit(UpdateUserFailureState(errorMessage: 'Something went wrong'));
    }
  }

//  update the user password with the old and the new password entered by the user
  void updateUserPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(UpdateUserPasswordLoadingState());

      final response = await DioHelper.postData(
        url: ApiConstants.changePasswordEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "current_password": oldPassword,
          "new_password": newPassword,
        },
      );

      if (response.data['status'] == true) {
        // userModel = LoginModel.fromJson(response.data);
        // CacheHelper.saveData(key: userName, value: userModel!.data!.name);
        // CacheHelper.saveData(key: userEmail, value: userModel!.data!.email);

        // CacheHelper.saveData(key: userPhone, value: userModel!.data!.phone);

        // print('${userModel!.data!.name} is the current user ');
        emit(UpdateUserPasswordSuccessState());
      } else {
        emit(UpdateUserPasswordFailureState(
            errorMessage: response.data['message']));
      }
    } catch (error) {
      print(error.toString());
      emit(
          UpdateUserPasswordFailureState(errorMessage: 'Something went wrong'));
    }
  }

  bool isObscured = false;
  void changePasswordVisibility() {
    isObscured = !isObscured;
    emit(ChangePasswordVisibility());
  }

  bool isNewObscured = false;
  void changeNewPasswordVisibility() {
    isNewObscured = !isNewObscured;
    emit(ChangePasswordVisibility());
  }
}
