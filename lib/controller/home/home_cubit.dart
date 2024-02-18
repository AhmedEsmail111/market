import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/controller/home/home_states.dart';
import '/models/categories/categories_model.dart' as categories_model;
import '/models/home/home_model.dart';
import '/modules/cart/cart_screen.dart';
import '/modules/favorites/favorites_screen.dart';
import '/modules/products/products_screen.dart';
import '/modules/settings/settings_screen.dart';
import '/shared/constants/api_constant.dart';
import '/shared/constants/constants.dart';
import '/shared/network/local/local_database.dart';
import '/shared/network/local/shared_preference.dart';
import '/shared/network/remote/remote.dart';

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

  List<String> banners = [];
  var isLoading = true;
  // see if there is data already cached and if that is the case we show it to the user
  //if not we make an api call and cache the data
  Future<void> setData() async {
    // get the count of the banners table
    final count = await LocalDatabase.getCount(AppConstants.productsTable);
    isLoading = true;
    emit(GetDataLoadingState());
    // if zero that means no data is cached , make an api call to fetch and cache the data
    if (count == 0) {
      final isHomeDoneFetching = await getHomeData();
      final isCategoriesDoneFetching = await getCategoriesData();

      // when fetching and caching are done get data  from local storage
      if (isHomeDoneFetching && isCategoriesDoneFetching) {
        await LocalDatabase.getProducts().then(
          (value) {
            homeModel = HomeModel(
              products:
                  value.map((product) => Product.fromJson(product)).toList(),
            );
          },
        );

        await LocalDatabase.getBanners().then((value) {
          banners = value.map((e) => e['image'] as String).toList();
        });

        await LocalDatabase.getCategories().then((value) {
          categoryModel = categories_model.CategoriesModel(
              data: value
                  .map(
                    (cat) => categories_model.Category(
                      id: cat['id'] as int,
                      name: cat['name'] as String,
                      image: cat['image'] as String,
                    ),
                  )
                  .toList());
        });
        isLoading = false;
        emit(GetDataLocallySuccessState());
      }

      // if not we have the data locally , get it and show it to the user
    } else {
      await LocalDatabase.getProducts().then(
        (value) {
          homeModel = HomeModel(
            products:
                value.map((product) => Product.fromJson(product)).toList(),
          );
        },
      );

      await LocalDatabase.getBanners().then((value) {
        banners = value.map((e) => e['image'] as String).toList();
      });

      await LocalDatabase.getCategories().then((value) {
        categoryModel = categories_model.CategoriesModel(
            data: value
                .map(
                  (cat) => categories_model.Category(
                    id: cat['id'] as int,
                    name: cat['name'] as String,
                    image: cat['image'] as String,
                  ),
                )
                .toList());
      });
      isLoading = false;
      emit(GetDataLocallySuccessState());
    }
  }

  HomeModel? homeModel;

//  get the home products and banners data
  Future<bool> getHomeData() async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetHomeDataLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.homeEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        // save banners locally
        for (final banner in response.data["data"]["banners"]) {
          await LocalDatabase.insertBanner(banner['id'], banner['image']);
          banners.add(banner['image']);
        }

        // save products locally
        for (final product in response.data["data"]["products"]) {
          final decodedImages = json.encode(product['images']);
          LocalDatabase.insertProduct(
            id: product['id'],
            price: product['price'],
            oldPrice: product['old_price'],
            discount: product['discount'],
            name: product['name'],
            images: decodedImages,
            image: product['image'],
            description: product['description'],
            inFavorites: product['in_favorites'],
            inCart: product['in_cart'],
          );
        }
        emit(GetHomeDataSuccessState());
        return true;
      } else {
        emit(GetHomeDataFailureState());
        return false;
      }
    } catch (error) {
      print(error.toString());
      emit(GetHomeDataFailureState());
      return false;
    }
  }

  categories_model.CategoriesModel? categoryModel;

  Future<bool> getCategoriesData() async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetCategoriesDataLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.getCategoriesEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        for (final category in response.data["data"]["data"]) {
          await LocalDatabase.insertCategory(
              id: category['id'],
              name: category['name'],
              image: category['image']);
        }

        // print('${categoryModel.data.length} number of categories');
        emit(GetCategoriesDataSuccessState());
        return true;
      } else {
        emit(GetCategoriesDataFailureState());
        return false;
      }
    } catch (error) {
      print(error.toString());
      emit(GetCategoriesDataFailureState());

      return false;
    }
  }

  var sliderIndex = 0;
  void changeSliderIndex(int toIndex) {
    sliderIndex = toIndex;
    emit(ChangeSliderIndexState());
  }
}
