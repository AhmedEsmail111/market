import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search/search_model.dart';

import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';
import '/controller/search/search_states.dart';
import '/shared/constants/api_constant.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super((InitialSearchState()));

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void search(String query) async {
    final userToken = CacheHelper.getData(key: token);
    try {
      emit(LoadingSearchState());
      final response = await DioHelper.postData(
        url: searchEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: languageKey) ?? 'en',
        data: {"text": query},
      );
      print('data is ${response.data}');

      if (response.data['status'] == true) {
        searchModel = SearchModel.fromJson(response.data);
        print('got search successfully');

        emit(SuccessSearchState());
      } else {
        print('error getting search');
        emit((FailureSearchState(errorMessage: 'something went wrong')));
      }
    } catch (error) {
      print(error.toString());
      emit(FailureSearchState(errorMessage: 'something went wrong'));
    }
  }
}
