import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/controller/favorites/favorites_states.dart';

import '../../models/change_favorite/change_favorite_model.dart';
import '../../models/favorites/favorites_model.dart';
import '../../shared/components/toast_message.dart';
import '../../shared/constants/api_constant.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(InitialFavoritesState());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  // // a method to initialize favorites through reading from storage
  // void initFavorites() {
  //   final json = TLocaleStorage.instance().readData('favorites');
  //   if (json != null) {
  //     final storeFavs = jsonDecode(json) as Map<String, dynamic>;
  //     favorites.addAll(storeFavs
  //         .map((key, value) => MapEntry(int.parse(key), value as bool)));
  //     print('init Successfully');
  //   }
  // }

  // void saveFavoritesToStorage() {
  //   final reversedFavs =
  //       favorites.map((key, value) => MapEntry(key.toString(), value));
  //   final encodedFavorites = jsonEncode(reversedFavs);

  //   TLocaleStorage.instance().saveData('favorites', encodedFavorites);
  //   print('savedSuccessfully');
  // }

  FavoritesModel? favoritesModel;
  // a map to manage favorites locally
  Map<int, bool> favorites = {};
  bool isFavorite(int productId) => favorites.containsKey(productId);
  // get all favorites
  void getFavorites({bool isFirst = true}) async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetFavoritesLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.favoritesEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        favoritesModel = FavoritesModel.fromJson(response.data);
        // the first time the app starts add favorites to the favorites map
        if (isFirst) {
          favorites = {};
          for (final item in favoritesModel!.data) {
            favorites.addAll(
              {item.product.id: true},
            );
          }
        }

        print('${favoritesModel!.data.length} number of favorites');
        emit(GetFavoritesSuccessState());
      } else {
        emit(GetFavoritesFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetFavoritesFailureState());
    }
  }

  ChangeFavoriteModel? changeFavoriteModel;
  // change the favorite status of a given products
  void changeFavoriteStatus(int productId, bool status) async {
    if (status) {
      // if the status was true then unfav the product
      favorites.remove(productId);

      // else if the status was false then make the the product favorite
    } else {
      favorites.addAll({productId: true});
    }
    ;
    emit(ChangeFaveLocalState());

    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(ChangeFaveLoadingState());

      final response = await DioHelper.postData(
        url: ApiConstants.favoritesEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        query: {'product_id': productId},
      );

      changeFavoriteModel = ChangeFavoriteModel.fromJson(response.data);

      // if the call to the server was made successfully then make another call to get the latest favorites
      if (changeFavoriteModel!.status == true) {
        getFavorites(isFirst: false);
        emit(ChangeFaveSuccessState());

        // else return the product locally to its previous status and show a toast message
      } else {
        if (status) {
          favorites.addAll({productId: true});
        } else {
          favorites.remove(productId);
        }
        emit(ChangeFaveFailureState());
        buildToastMessage(
          message: 'Something went wrong!',
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          background: const Color.fromARGB(255, 173, 16, 4).withOpacity(0.8),
        );
      }
    } catch (error) {
      print(error.toString());

      if (status) {
        favorites.addAll({productId: true});
      } else {
        favorites.remove(productId);
      }
      emit(ChangeFaveFailureState());
      buildToastMessage(
        message: 'Something went wrong!',
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        background: const Color.fromARGB(255, 173, 16, 4).withOpacity(0.8),
      );
    }
  }
}
