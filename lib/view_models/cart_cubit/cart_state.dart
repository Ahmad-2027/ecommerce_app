part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartItemsLoading extends CartState {}

final class CartItemsLoaded extends CartState {
  final List<CartModel> items;
  final double subtotal;
  CartItemsLoaded({required this.items, required this.subtotal});
}

final class CartItemsLoadingError extends CartState {
  final String message;
  CartItemsLoadingError({required this.message});
}

final class QuantityCounterChangingInCartPage extends CartState {
  final String cartItemId;
  final int expectedValue;
  QuantityCounterChangingInCartPage({required this.expectedValue,required this.cartItemId});
}

final class QuantityCounterChangingInCartPageError extends CartState {
    final String cartItemId;
  final String message;
  final int oldValue;
  QuantityCounterChangingInCartPageError({
    required this.message,
    required this.oldValue,
    required this.cartItemId
  });
}

final class QuantityCounterChangedInCartPage extends CartState {
  final CartModel cartModel;
    final String cartItemId;
  final double newSubTotal;
  QuantityCounterChangedInCartPage({
    required this.cartModel,
    required this.newSubTotal,
    required this.cartItemId
  });
}

final class CartItemRemoving extends CartState {}

final class CartItemRemoved extends CartState {}

final class CartItemRemovingError extends CartState {
  final String message;
  CartItemRemovingError({required this.message});
}
