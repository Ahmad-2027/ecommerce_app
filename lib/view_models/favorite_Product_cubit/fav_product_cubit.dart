import 'package:ecommerce_app/models/fav_product_details.dart';
import 'package:ecommerce_app/models/favorite_product_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_product_state.dart';

class FavProductCubit extends Cubit<FavProductState> {
  FavProductCubit() : super(FavProductInitial());
  String? selectedPRoductId;
  final favServices = FavoriteServicesImp();
  final authServices = AuthServicesImp();

  Future<void> addToFavorites(String productId) async {
    try {
      emit(AddingProductToFavorites());
      final favProduct = FavoriteProductModel(
        id: DateTime.now().toIso8601String(),
        productId: productId,
      );
      final user = authServices.currentUser();
      await favServices.addFavoriteProduct(favProduct, user!.uid);
      emit(AddedProductToFavorites(favProduct.id));
    } catch (e) {
      emit(AddingProductToFavoritesError(e.toString()));
    }
  }

  Future<void> removeFromFavorites(String favProductId) async {
    try {
      emit(RemovingProductFromFavorites());

      final user = authServices.currentUser();
      await favServices.removeFavoriteProduct(favProductId, user!.uid);
      emit(RemovedProductFromFavorites());
    } catch (e) {
      emit(RemovingProductToFavoritesError(e.toString()));
    }
  }
Future<List<FavoriteProductWithDetails>>
    fetchFavProductsDetails() async {
  try {
    emit(FetchingFavoriteProducts());

    final favProducts =
        await favServices.fetchFavoritesProductList(
      authServices.currentUser()!.uid,
    );

    if (favProducts.isEmpty) {
      emit(FetchedFavoriteProducts([]));
      return [];
    }

    final productIds = favProducts
        .map((favProduct) => favProduct.productId)
        .toList();

    final products = await favServices.fetchProductsByIds(
      productIds,
    );

    final result = <FavoriteProductWithDetails>[];

    for (final favProduct in favProducts) {
      final product = products.cast<ProductItemModel?>().firstWhere(
        (p) => p?.id == favProduct.productId,
        orElse: () => null,
      );

      if (product != null) {
        result.add(
          FavoriteProductWithDetails(
            favId: favProduct.id,
            product: product,
          ),
        );
      }
    }

    emit(
      FetchedFavoriteProducts(result),
    );

    return result;
  } catch (e) {
    emit(
      FetchingFavoriteProductsError(
        e.toString(),
      ),
    );

    return [];
  }
}
}
