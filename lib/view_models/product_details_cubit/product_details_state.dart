part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  final String? favId;
  ProductDetailsLoaded({required this.product,required this.favId});
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

final class ProductAddingToCartError extends ProductDetailsState {
  final String message;
  ProductAddingToCartError({required this.message});
}
