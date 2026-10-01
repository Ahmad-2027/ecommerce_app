part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutItemsLoading extends CheckoutState {}

final class CheckoutItemsLoaded extends CheckoutState {
  final List<CartModel> cartItems;
  final double totalAmount;
  final int numOfProducts;
  final PaymentCardModel? paymentMethod;
  final LocationModel? shippingLocation;
  CheckoutItemsLoaded({
    required this.cartItems,
    required this.numOfProducts,
    required this.totalAmount,
    required this.paymentMethod,
    required this.shippingLocation
  });
}

final class CheckoutItemsLoadingError extends CheckoutState {
  final String message;
  CheckoutItemsLoadingError({required this.message});
}
