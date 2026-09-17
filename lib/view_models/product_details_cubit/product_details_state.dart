part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLoaded({required this.product});
}

final class ProductDetailsLoadingError extends ProductDetailsState {
  final String message;
  ProductDetailsLoadingError({required this.message});
}

final class QuantityCounterChangedInProductDetailsPage
    extends ProductDetailsState {
  final int value;
  QuantityCounterChangedInProductDetailsPage({required this.value});
}

final class ProductSizeSelected extends ProductDetailsState {
  final ProductSize? size;
  ProductSizeSelected({required this.size});
}

final class ProductAddingToCart extends ProductDetailsState {}

final class ProductAddedToCart extends ProductDetailsState {
  final String productId;
  ProductAddedToCart({required this.productId});
}
