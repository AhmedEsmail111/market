import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/complaint/complaint_states.dart';
import 'package:shop_app/shared/constants/api_constant.dart';

import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';

class ComplaintCubit extends Cubit<ComplaintStates> {
  ComplaintCubit() : super(InitialComplaintState());

  static ComplaintCubit get(context) => BlocProvider.of(context);

  var isAddingComplaint = false;
  void addComplaint(String complaint) async {
    isAddingComplaint = true;
    try {
      // final userToken = CacheHelper.getData(key: token);
      emit(AddComplaintLoadingState());

      final response = await DioHelper.postData(
          url: addComplaintsEndPoint,
          // token: userToken,
          lang: CacheHelper.getData(key: languageKey) ?? 'en',
          data: {
            "name": CacheHelper.getData(key: userName),
            "phone": CacheHelper.getData(key: userPhone),
            "email": CacheHelper.getData(key: userEmail),
            "message": complaint
          });
      // print(response.data);
      if (response.data['status'] == true) {
        isAddingComplaint = false;
        emit(AddComplaintSuccessState());
      } else {
        isAddingComplaint = false;
        emit(AddComplaintFailureState());
      }
    } catch (error) {
      isAddingComplaint = false;
      print(error.toString());
      emit(AddComplaintFailureState());
    }
  }

  var complaint = '';
  void changeComplaint(String newComplaint) {
    complaint = newComplaint;
    emit(ChangeComplaintState());
  }
}
