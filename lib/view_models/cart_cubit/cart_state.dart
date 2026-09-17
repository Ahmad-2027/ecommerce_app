part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartItemsLoading extends CartState {}

final class CartItemsLoaded extends CartState {
  final List<AddToCartModel> items;
  final double subtotal;
  CartItemsLoaded({required this.items, required this.subtotal});
}

final class CartItemsLoadingError extends CartState {
  final String message;
  CartItemsLoadingError({required this.message});
}

final class QuantityCounterChangedInCartPage extends CartState {
  final int value;
  final String productId;
  final double newSubTotal;
  QuantityCounterChangedInCartPage({
    required this.value,
    required this.productId,
    required this.newSubTotal,
  });
}
