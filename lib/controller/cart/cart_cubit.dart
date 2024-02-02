import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/cart/payment.dart';

import '../../models/orders/orders_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';
import '/controller/cart/cart_states.dart';
import '/models/cart/add_remove_model.dart';
import '/models/cart/cart_model.dart';
import '/shared/components/toast_message.dart';
import '/shared/constants/api_constant.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitialCartState());

  static CartCubit get(context) => BlocProvider.of(context);

  // Razorpay? razorpay;
  // Map<String, Object>? options;

  // void initRazpory() {
  //   razorpay = Razorpay();
  //   options = {
  //     'key': 'rzp_test_1DP5mmOlF5G5ag',
  //     'amount': 100,
  //     'name': 'Acme Corp.',
  //     'description': 'Fine T-Shirt',
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
  // }

  // void handlePaymentSuccess(PaymentSuccessResponse response, context) {
  //   buildToastMessage(
  //     message: ' payment success with ${response.orderId}',
  //     gravity: ToastGravity.CENTER,
  //     textColor: Theme.of(context).colorScheme.onSecondary,
  //     background: Theme.of(context).colorScheme.secondary,
  //   );
  // }

  // void handlePaymentError(PaymentFailureResponse response, context) {
  //   // Do something when payment fails
  //   buildToastMessage(
  //     message: ' payment fails with ${response.message}',
  //     gravity: ToastGravity.CENTER,
  //     textColor: Theme.of(context).colorScheme.onSecondary,
  //     background: Theme.of(context).colorScheme.secondary,
  //   );
  // }

  // void handleExternalWallet(ExternalWalletResponse response, context) {
  //   // Do something when an external wallet was selected
  //   buildToastMessage(
  //     message: ' payment done with ${response.walletName}',
  //     gravity: ToastGravity.CENTER,
  //     textColor: Theme.of(context).colorScheme.onSecondary,
  //     background: Theme.of(context).colorScheme.secondary,
  //   );
  // }

  List<int> cartItems = [];
  Map<int, int> cartMap = {};
  CartModel? cartModel;

  Future<void> getCart({bool isFirst = true, bool fetch = true}) async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetCartLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.cartEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );
      // print(response.data);
      if (response.data['status'] == true) {
        // print(response.data);
        cartModel = CartModel.fromJson(response.data);
        if (fetch) {
          cartItems = [];
          for (final item in cartModel!.data.cartItems) {
            cartItems.add(item.product.id);
          }
        }

        // initialize the map with ddta from the server the first time we make a call
        if (isFirst) {
          for (final item in cartModel!.data.cartItems) {
            cartMap.addAll({item.id: item.quantity});
          }
        }
        print('${cartModel!.data.cartItems.length} number of cart items');
        emit(GetCartSuccessState());
      } else {
        emit(GetCartFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetCartFailureState());
    }
  }

  var isAddRemoveDone = true;
  AddRemoveCartModel? addRemoveCartModel;
  Future<void> addOrRemoveFromCart(int productId) async {
    isAddRemoveDone = false;
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(ToggleProductInCartLoading());

      final response = await DioHelper.postData(
        url: ApiConstants.cartEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "product_id": productId,
        },
      );
      // print(response.data);
      if (response.data['status'] == true) {
        addRemoveCartModel = AddRemoveCartModel.fromJson(response.data);
        if (addRemoveCartModel!.data!.product.name != null) {
          cartItems.add(productId);
          print(' add is done ${cartItems.length}');
        } else {
          cartItems.remove(productId);
          print('remove is done ${cartItems.length}');
        }

        // print('${cartModel!.data.cartItems.length} number of cart items');
        isAddRemoveDone = true;
        emit(ToggleProductInCartSuccess(
            successMessage: addRemoveCartModel!.message));
        // print(cartItems.length);
        getCart(fetch: false);
      } else {
        isAddRemoveDone = true;
        emit(ToggleProductInCartFailure());
      }
    } catch (error) {
      isAddRemoveDone = true;
      print(error.toString());
      emit(ToggleProductInCartFailure());
    }
  }

  void changeQuantity({required int itemId, required int quantity}) async {
    // isChangingDone = false;
    final previousQuantity = cartMap[itemId];

    cartMap[itemId] = quantity;
    print(cartMap[itemId]);
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(ChangeQuantityInCartLoading());

      final response = await DioHelper.putData(
        url: '${ApiConstants.cartEndPoint}/$itemId',
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "quantity": quantity,
        },
      );

      if (response.data['status'] == true) {
        getCart(isFirst: false);
        // .then((value) => isChangingDone = true);
        print(cartMap[itemId]);
        emit(ChangeQuantityInCartSuccess());
        // print(cartItems.length);
      } else {
        cartMap[itemId] = previousQuantity!;
        buildToastMessage(
          message: 'Something went wrong!',
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          background: const Color.fromARGB(255, 136, 14, 6).withOpacity(0.8),
        );
        // isChangingDone = true;
        emit(ChangeQuantityInCartFailure());
      }
    } catch (error) {
      cartMap[itemId] = previousQuantity!;
      buildToastMessage(
        message: 'Something went wrong!',
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        background: const Color.fromARGB(255, 136, 14, 6).withOpacity(0.8),
      );
      // isChangingDone = true;
      print(error.toString());
      emit(ChangeQuantityInCartFailure());
    }
  }

  var isRemoving = false;
  void removeItem(int itemId) async {
    isRemoving = true;
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(RemoveItemInCartLoading());

      final response = await DioHelper.deleteData(
        url: '${ApiConstants.cartEndPoint}/$itemId',
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );
      // print(response.data);
      if (response.data['status'] == true) {
        // addRemoveCartModel = AddRemoveCartModel.fromJson(response.data);

        // print('${cartModel!.data.cartItems.length} number of cart items');

        await getCart();
        isRemoving = false;

        emit(RemoveItemInCartSuccess());

        // print(cartItems.length);
      } else {
        isRemoving = false;
        emit(RemoveItemInCartFailure());
      }
    } catch (error) {
      isRemoving = false;
      print(error.toString());
      emit(RemoveItemInCartFailure());
    }
  }

  Future<void> validatePromoCode(String code) async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(ValidatePromoCodeLoading());

      final response = await DioHelper.postData(
        url: ApiConstants.promoCodeEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "code": code,
        },
      );
      // print(response.data);
      if (response.data['status'] == true) {
        emit(
            ValidatePromoCodeSuccess(successMessage: response.data['message']));
      } else {
        emit(ValidatePromoCodeFailure(errorMessage: response.data['message']));
      }
    } catch (error) {
      print(error.toString());
      emit(ValidatePromoCodeFailure(errorMessage: 'something went wrong!'));
    }
  }

  var isAddingOrder = false;
  void addOrder({required int paymentMethod, required int addressId}) async {
    isAddingOrder = true;
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(AddOrderLoadingState());

      final response = await DioHelper.postData(
        url: ApiConstants.orderEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
        data: {
          "address_id": addressId,
          "payment_method": paymentMethod,
          "use_points": false
        },
      );
      // print(response.data);
      if (response.data['status'] == true) {
        await getCart();
        getOrders().then((value) => isAddingOrder = false);
        emit(AddOrderSuccessState());
      } else {
        print(response.data['message']);
        emit(AddOrderFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(AddOrderFailureState());
    }
  }

  OrdersModel? ordersModel;
  Future<void> getOrders() async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetOrdersLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.orderEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );
      print(response.data);
      if (response.data['status'] == true) {
        ordersModel = OrdersModel.fromJson(response.data);
        emit(GetOrdersSuccessState());
      } else {
        emit(GetOrdersFailureState());
      }
    } catch (error) {
      print(error.toString());
      emit(GetCartFailureState());
    }
  }

  bool isCancellingOrder = false;
  cancelOrder(int orderId, int orderIndex) async {
    isCancellingOrder = true;
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(CancelOrderLoadingState());

      final response = await DioHelper.getData(
        url: '${ApiConstants.orderEndPoint}/$orderId/cancel',
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );
      // print(response.data);
      if (response.data['status'] == true) {
        isCancellingOrder = false;
        ordersModel!.data.orders[orderIndex].status = 'Cancelled';
        // orderDetailsModel = OrderDetailsModel.fromJson(response.data);
        // print(orderDetailsModel!.status);
        emit(CancelOrderSuccessState());
      } else {
        isCancellingOrder = false;
        emit(CancelOrderFailureState());
      }
    } catch (error) {
      isCancellingOrder = false;
      print(error.toString());
      emit(CancelOrderFailureState());
    }
  }

  List<PaymentModel> payments = [
    PaymentModel(
        name: CacheHelper.getData(key: AppConstants.languageKey) == 'ar'
            ? 'بوابة الدفع بايبال'
            : 'Paypal',
        image: 'assets/images/paypal.jpg'),
    PaymentModel(
        name: CacheHelper.getData(key: AppConstants.languageKey) == 'ar'
            ? 'بطاقة ماستر كارد'
            : 'Mastercard',
        image: 'assets/images/mastercard.jpg'),
    PaymentModel(
        name: CacheHelper.getData(key: AppConstants.languageKey) == 'ar'
            ? 'بطاقة فيزا'
            : 'Visa',
        image: 'assets/images/visa.jpg'),
    PaymentModel(
        name: CacheHelper.getData(key: AppConstants.languageKey) == 'a'
            ? 'الدفع عند الإستلام'
            : 'Cash on Delivery',
        image: 'assets/images/pay.jpg'),
  ];
  var chosenPaymentIndex = 3;
  void changePayment(int newPaymentIndex) {
    chosenPaymentIndex = newPaymentIndex;
    emit(ChangePaymentIndexState());
  }

  double getTotal(List<CartItem> items) {
    double total = 0;
    for (final item in items) {
      total += cartMap[item.id]! * item.product.price;
    }

    return total;
  }

  var code = '';

  void changeCode(String newCode) {
    code = newCode;
    emit(ChangeCodeState());
  }
}
