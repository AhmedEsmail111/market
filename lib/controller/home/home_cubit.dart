import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/home/home_states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/constants/api_constant.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/shared_preference.dart';
import 'package:shop_app/shared/network/remote/remote.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  var currentIndex = 0;
  void changeBottomNavBarIndex(index) {
    currentIndex = index;
    print('current $index');
    emit(ChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  // bool favoritesLoaded = false;
  void getHomeData() async {
    // favoritesLoaded = false;
    try {
      final userToken = CacheHelper.getData(key: token);
      emit(GetHomeDataLoadingState());

      final response = await DioHelper.getData(
        url: homeEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        homeModel = HomeModel.fromJson(response.data);

        // favoritesLoaded = true;
        print('${homeModel!.data.products.length} number of products');
        emit(GetHomeDataSuccessState());
      } else {
        // favoritesLoaded = false;
        emit(GetHomeDataFailureState());
      }
    } catch (error) {
      // favoritesLoaded = false;
      print(error.toString());
      emit(GetHomeDataFailureState());
    }
  }

  CategoriesModel? categoryModel;

  void getCategoriesData() async {
    try {
      final userToken = CacheHelper.getData(key: token);
      emit(GetCategoriesDataLoadingState());

      final response = await DioHelper.getData(
        url: getCategoriesEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        categoryModel = CategoriesModel.fromJson(response.data);

        print('${categoryModel!.data.length} number of categories');
        emit(GetCategoriesDataSuccessState());
      } else {
        emit(GetCategoriesDataFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetCategoriesDataFailureState());
    }
  }

  var sliderIndex = 0;
  void changeSliderIndex(int toIndex) {
    sliderIndex = toIndex;
    emit(ChangeSliderIndexState());
  }
}
