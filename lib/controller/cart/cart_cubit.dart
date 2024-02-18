import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/orders/orders_model.dart';
import '../../shared/components/toast_message.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/local/shared_preference.dart';
import '../../shared/network/remote/remote.dart';
import '/controller/cart/cart_states.dart';
import '/models/cart/add_remove_model.dart';
import '/models/cart/cart_model.dart';
import '/models/cart/payment.dart';
import '/shared/constants/api_constant.dart';
import '/shared/styles/colors.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(InitialCartState());

  static CartCubit get(context) => BlocProvider.of(context);
// a list of int to store all the ids of the items in the cart
//to know if a certain product is already in the cart or not
  List<int> cartItems = [];
  // a map to control the quantity of each items in the cart
  Map<int, int> cartMap = {};

  CartModel? cartModel;
// get all items in the cart
  Future<void> getCart({bool isFirst = true, bool fetch = true}) async {
    try {
      final userToken = CacheHelper.getData(key: AppConstants.token);
      emit(GetCartLoadingState());

      final response = await DioHelper.getData(
        url: ApiConstants.cartEndPoint,
        token: userToken,
        lang: CacheHelper.getData(key: AppConstants.languageKey) ?? 'en',
      );

      if (response.data['status'] == true) {
        cartModel = CartModel.fromJson(response.data);
        // if true will reset the cartItems list and store the values again
        if (fetch) {
          cartItems = [];
          for (final item in cartModel!.data.cartItems) {
            cartItems.add(item.product.id);
          }
        }

        // if true will reset the cartMap map object and store the values again
        if (isFirst) {
          cartMap = {};
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

// to know if we are currently adding an item to the cart or not
  var isAddRemoveDone = true;
  AddRemoveCartModel? addRemoveCartModel;
  // adds or removes an item from the cart depending on whether this item is already in the list or not
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

      if (response.data['status'] == true) {
        addRemoveCartModel = AddRemoveCartModel.fromJson(response.data);
        if (addRemoveCartModel!.data!.product.name != null) {
          // we add it it locally to the list too
          cartItems.add(productId);
          print(' add is done ${cartItems.length}');
        } else {
          //and we remove it  locally from the list if it was already there too
          cartItems.remove(productId);
          print('remove is done ${cartItems.length}');
        }

        isAddRemoveDone = true;
        emit(ToggleProductInCartSuccess(
            successMessage: addRemoveCartModel!.message));

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

// change the quantity of an item in the list make the update looks as if it real time utilizing the cartMap map object
  void changeQuantity({required int itemId, required int quantity}) async {
    // store the previous quantity to use it in case of an error
    final previousQuantity = cartMap[itemId];

    cartMap[itemId] = quantity;

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

        emit(ChangeQuantityInCartSuccess());
      } else {
        // if error happened go back to the previous value
        cartMap[itemId] = previousQuantity!;
        buildToastMessage(
          message: 'Something went wrong!',
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          background: const Color.fromARGB(255, 136, 14, 6).withOpacity(0.8),
        );

        emit(ChangeQuantityInCartFailure());
      }
    } catch (error) {
      // if error happened go back to the previous value
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
  // remove am item from the cart
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

      if (response.data['status'] == true) {
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

// validate a promo code
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

// to know if the adding process is done?
  var isAddingOrder = false;
  // adds an order to the database using the payment method and the addressId
  Future<void> addOrder(
      {required int paymentMethod, required int addressId}) async {
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
  // get all the orders in the database
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
  // cancels an order and change this orders details using its index in the ordersModel to be "Cancelled"
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

        ordersModel!.data.orders[orderIndex].status =
            CacheHelper.getData(key: AppConstants.languageKey) == 'ar'
                ? 'ملغي'
                : 'Cancelled';

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
            ? 'الدفع اونلاين'
            : 'Online payment',
        image: 'assets/images/visa.jpg'),
    PaymentModel(
        name: CacheHelper.getData(key: AppConstants.languageKey) == 'a'
            ? 'الدفع عند الإستلام'
            : 'Cash on Delivery',
        image: 'assets/images/pay.jpg'),
  ];
  var chosenPaymentIndex = 1;
  void changePayment(int newPaymentIndex) {
    chosenPaymentIndex = newPaymentIndex;
    emit(ChangePaymentIndexState());
  }

// returns the total of the order using the items in the order
  double getTotal(List<CartItem> items) {
    double total = 0;
    for (final item in items) {
      total += cartMap[item.id]! * item.product.price;
    }

    return total;
  }

// controls whether the user has entered a code to be verified or not
  var code = '';
  void changeCode(String newCode) {
    code = newCode;
    emit(ChangeCodeState());
  }

// the main method that handles the payment process
  Future<void> makePayment(int amount, String currency, context,
      {required int paymentMethod, required int addressId}) async {
    try {
      final response =
          await _getClientSecret((amount * 100).toString(), currency);

      await _initPaymentSheet(response.data['client_secret'], context);
// show the payment sheet we created and if the payment is successful we add the order to the data
      await Stripe.instance
          .presentPaymentSheet()
          .then(
            (value) =>
                addOrder(paymentMethod: paymentMethod, addressId: addressId),
          )
          .onError((error, stackTrace) => print('on Error'));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
      rethrow;
    }
  }

// initialize the payment sheet to be displayed to the user and make some custom appearance modifications
  Future<void> _initPaymentSheet(String clientSecret, context) async {
    final bool isDark =
        CacheHelper.getData(key: AppConstants.isDarkMode) == true;
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Market',
          appearance: PaymentSheetAppearance(
            colors: const PaymentSheetAppearanceColors().copyWith(
              background: isDark ? AppColors.blackColor : null,
              primary: isDark ? Colors.white : null,
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: const PaymentSheetPrimaryButtonTheme().copyWith(
                dark: PaymentSheetPrimaryButtonThemeColors(
                  background: Theme.of(context).colorScheme.primary,
                  text: Theme.of(context).colorScheme.onPrimary,
                ),
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Theme.of(context).colorScheme.primary,
                  text: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      print('error in _initPayment  ${e.toString()}');
      rethrow;
    }
  }

// communicate with stripe to inform her with a new payment intent to be created
//and returns the response from stripe that contains the client secret
  Future<Response> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    try {
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: {
          'amount': amount,
          'currency': currency,
        },
      );
      print(response.data); // Print response details for debugging
      return response;
    } catch (error) {
      print('Error in _getClientSecret: $error');
      rethrow;
    }
  }
}
