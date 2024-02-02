import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/authentication/authentication_states.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/shared/constants/api_constant.dart';
import 'package:shop_app/shared/network/remote/remote.dart';

import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(InitialAuthenticationState());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  bool isObscured = false;

  void changePasswordVisibility() {
    isObscured = !isObscured;
    print(isObscured);
    emit(AuthenticationChangePasswordVisibility());
  }

  LoginModel? loginModel;
  void loginUser({required String email, required String password}) async {
    emit(AuthenticationLoginLoadingState());
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.loginEndPoint,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          'email': email,
          'password': password,
        },
      );
      print(response.data);
      loginModel = LoginModel.fromJson(response.data);
      if (loginModel != null) {
        if (loginModel!.status == false) {
          emit(AuthenticationLoginErrorState(error: loginModel!.message));
        } else {
          // TLocaleStorage.initStorage(loginModel!.data!.id.toString()).then(
          //     (value) =>
          emit(AuthenticationLoginSuccessState(model: loginModel!));
          // );
        }
      }
    } catch (error) {
      print(error.toString());
      emit(
        AuthenticationLoginErrorState(error: error.toString()),
      );
    }
  }

  void registerUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    emit(AuthenticationRegisterLoadingState());
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.registerEndPoint,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        },
      );
      print(response.data);
      loginModel = LoginModel.fromJson(response.data);
      if (loginModel != null) {
        if (loginModel!.status == false) {
          emit(AuthenticationRegisterErrorState(error: loginModel!.message));
        } else {
          // TLocaleStorage.initStorage(loginModel!.data!.id.toString()).then(
          //     (value) =>
          emit(AuthenticationRegisterSuccessState(model: loginModel!));
          // );
        }
      }
    } catch (error) {
      print(error.toString());
      emit(
        AuthenticationRegisterErrorState(error: error.toString()),
      );
    }
  }
}
