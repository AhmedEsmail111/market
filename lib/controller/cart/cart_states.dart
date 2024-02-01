abstract class CartStates {}

class InitialCartState extends CartStates {}

class GetCartLoadingState extends CartStates {}

class GetCartSuccessState extends CartStates {}

class GetCartFailureState extends CartStates {}

class ToggleProductInCartLoading extends CartStates {}

class ToggleProductInCartSuccess extends CartStates {
  final String successMessage;

  ToggleProductInCartSuccess({required this.successMessage});
}

class ToggleProductInCartFailure extends CartStates {}

class ChangeQuantityInCartLoading extends CartStates {}

class ChangeQuantityInCartSuccess extends CartStates {}

class ChangeQuantityInCartFailure extends CartStates {}

class RemoveItemInCartLoading extends CartStates {}

class RemoveItemInCartSuccess extends CartStates {}

class RemoveItemInCartFailure extends CartStates {}

class ValidatePromoCodeLoading extends CartStates {}

class ValidatePromoCodeSuccess extends CartStates {
  final String successMessage;

  ValidatePromoCodeSuccess({required this.successMessage});
}

class ValidatePromoCodeFailure extends CartStates {
  final String errorMessage;

  ValidatePromoCodeFailure({required this.errorMessage});
}

class ChangeCodeState extends CartStates {}

class ChangePaymentIndexState extends CartStates {}

class AddOrderLoadingState extends CartStates {}

class AddOrderSuccessState extends CartStates {}

class AddOrderFailureState extends CartStates {}

class GetOrdersLoadingState extends CartStates {}

class GetOrdersSuccessState extends CartStates {}

class GetOrdersFailureState extends CartStates {}

class GetOrderDetailsLoadingState extends CartStates {}

class GetOrderDetailsSuccessState extends CartStates {}

class GetOrderDetailsFailureState extends CartStates {}

class CancelOrderLoadingState extends CartStates {}

class CancelOrderSuccessState extends CartStates {}

class CancelOrderFailureState extends CartStates {}
