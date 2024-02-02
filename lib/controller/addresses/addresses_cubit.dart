import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/addresses/addresses_states.dart';

import '../../models/addresses/addresses_model.dart';
import '../../shared/constants/api_constant.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';

class AddressesCubit extends Cubit<AddressesStates> {
  AddressesCubit() : super(InitialAddressesState());

  static AddressesCubit get(context) => BlocProvider.of(context);
  bool isAddingAddress = false;
  void addAddress({
    required String name,
    required String city,
    required String phone,
    required String region,
    required String details,
    required String notes,
  }) async {
    isAddingAddress = true;
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(AddAddressLoadingState());

      final response = await DioHelper.postData(
        url: ApiConstants.addressesEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "name": name,
          "latitude": phone,
          "city": city,
          "region": region,
          "details": details,
          "notes": notes,
          'longitude': '123',
        },
      );

      if (response.data['status'] == true) {
        await getAddresses();
        isAddingAddress = false;
        emit(AddAddressSuccessState());
      } else {
        isAddingAddress = false;
        emit(AddAddressFailureState());
      }
    } catch (error) {
      isAddingAddress = false;
      print(error.toString());
      emit(AddAddressFailureState());
    }
  }

  void updateAddress({
    required String name,
    required String city,
    required String phone,
    required String region,
    required String details,
    required String notes,
    required int addressId,
  }) async {
    isAddingAddress = true;
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(UpdateAddressLoadingState());

      final response = await DioHelper.putData(
        url: "${ApiConstants.addressesEndPoint}/$addressId",
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "name": name,
          "latitude": phone,
          "city": city,
          "region": region,
          "details": details,
          "notes": notes,
          'longitude': '123',
        },
      );

      if (response.data['status'] == true) {
        await getAddresses();
        isAddingAddress = false;
        emit(UpdateAddressSuccessState());
      } else {
        isAddingAddress = false;
        emit(UpdateAddressFailureState());
      }
    } catch (error) {
      isAddingAddress = false;
      print(error.toString());
      emit(UpdateAddressFailureState());
    }
  }

  AddressesModel? addressesModel;
  Future<void> getAddresses() async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetAddressesLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.addressesEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        addressesModel = AddressesModel.fromJson(response.data);
        print(addressesModel!.data.length);

        emit(GetAddressesSuccessState());
      } else {
        emit(GetAddressesFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetAddressesFailureState());
    }
  }

  int? chosenAddressId = CacheHelper.getData(key: AppConstants.addressId);
  void changeAddressId(int newId) {
    chosenAddressId = newId;

    CacheHelper.saveData(key: AppConstants.addressId, value: newId);
    emit(ChangeChosenAddressId());
  }
}
