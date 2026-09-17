part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutItemsLoading extends CheckoutState {}

final class CheckoutItemsLoaded extends CheckoutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfProducts;
  final List<AddNewPaymentCardModel> paymentMethods;
  CheckoutItemsLoaded({
    required this.cartItems,
    required this.numOfProducts,
    required this.totalAmount,
    required this.paymentMethods
  });
}

final class CheckoutItemsLoadingError extends CheckoutState {
  final String message;
  CheckoutItemsLoadingError({required this.message});
}
