import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/category_products/category_products_states.dart';
import 'package:shop_app/models/search/search_model.dart';
import 'package:shop_app/shared/constants/api_constant.dart';

import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsStates> {
  CategoryProductsCubit() : super(InitialCategoryProductsState());

  static CategoryProductsCubit get(context) => BlocProvider.of(context);

  SearchModel? categoryProductsModel;

  void getCategoryProducts(int categoryId) async {
    try {
      final userToken = CacheHelper.getData(key: token);
      emit(GetCategoryProductsLoadingState());

      final response = await DioHelper.getData(
        url: '$getCategoriesEndPoint/$categoryId',
        token: userToken,
        lang: CacheHelper.getData(key: languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        categoryProductsModel = SearchModel.fromJson(response.data);

        print(
            '${categoryProductsModel!.searchData.productData.length} number of categoryProducts');
        emit(GetCategoryProductsSuccessState());
      } else {
        emit(GetCategoryProductsFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetCategoryProductsFailureState());
    }
  }
}
