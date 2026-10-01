part of 'fav_product_cubit.dart';

sealed class FavProductState {}

final class FavProductInitial extends FavProductState {}

final class AddingProductToFavorites extends FavProductState {}

final class AddedProductToFavorites extends FavProductState {
  final String favId;
  AddedProductToFavorites(this.favId);
}

final class AddingProductToFavoritesError extends FavProductState {
  final String message;
  AddingProductToFavoritesError(this.message);
}

final class RemovingProductFromFavorites extends FavProductState {}

final class RemovedProductFromFavorites extends FavProductState {}

final class RemovingProductToFavoritesError extends FavProductState {
  final String message;
  RemovingProductToFavoritesError(this.message);
}

final class FetchingFavoriteProducts extends FavProductState {}

final class FetchedFavoriteProducts extends FavProductState {
  final   List<FavoriteProductWithDetails> favProducts;
  FetchedFavoriteProducts(this.favProducts);
}

final class FetchingFavoriteProductsError extends FavProductState {
  final String message;
  FetchingFavoriteProductsError(this.message);
}
