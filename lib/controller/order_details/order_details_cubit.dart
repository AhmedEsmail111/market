import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/order_details/order_details_states.dart';

import '../../models/orders/order_details_model.dart';
import '../../shared/constants/api_constant.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsStates> {
  OrderDetailsCubit() : super(InitialOrderDetailsState());

  static OrderDetailsCubit get(context) => BlocProvider.of(context);

  OrderDetailsModel? orderDetailsModel;
  getOrderDetails(int orderId) async {
    try {
      final userToken = CacheHelper.getData(key: token);
      emit(GetOrderDetailsLoadingState());

      final response = await DioHelper.getData(
        url: '$orderEndPoint/$orderId',
        token: userToken,
        lang: CacheHelper.getData(key: languageKey) ?? 'en',
      );
      // print(response.data);
      if (response.data['status'] == true) {
        orderDetailsModel = OrderDetailsModel.fromJson(response.data);
        print(orderDetailsModel!.status);
        emit(GetOrderDetailsSuccessState());
      } else {
        emit(GetOrderDetailsFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetOrderDetailsFailureState());
    }
  }
}
