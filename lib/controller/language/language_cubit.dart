import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '/controller/language/language_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialLanguageState());
  static ShopCubit get(context) => BlocProvider.of(context);

  bool arabicStatus =
      CacheHelper.getData(key: languageKey) == 'ar' ? true : false;
  bool englishStatus =
      CacheHelper.getData(key: languageKey) == 'en' ? true : false;

  void changeLanguageStatus(bool status, int num) {
    if (num == 1) {
      arabicStatus = status;
      englishStatus = !arabicStatus;
      index = num;
    } else if (num == 0) {
      englishStatus = status;
      arabicStatus = !englishStatus;
      index = num;
    }
    emit(ChangeLanguageStatusState());
  }

  int? index;
  Locale locale = Locale(CacheHelper.getData(key: languageKey) ?? 'en');

  Future<void> setDefaultLanguage() async {
    if (index == 0 && CacheHelper.getData(key: languageKey) != 'en') {
      await CacheHelper.saveData(key: languageKey, value: 'en');
      locale = const Locale('en');
    }
    if (index == 1 && CacheHelper.getData(key: languageKey) != 'ar') {
      await CacheHelper.saveData(key: languageKey, value: 'ar');
      locale = const Locale('ar');
    }
    emit(SaveDefaultLanguageStatus());
  }

  void changeLanguage(bool check) async {
    if (check == false) {
      index = 0;
    } else {
      index = 1;
    }
    emit(SuccessChangeCheckLanguageState());
  }

  bool isDark = CacheHelper.getData(key: isDarkMode) ?? false;
  void setDarkMode() {
    isDark = !isDark;
    CacheHelper.saveData(key: isDarkMode, value: isDark);
    emit(ToggleDarkModeState());
  }
}
