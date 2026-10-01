import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/favorite_services.dart';
import 'package:ecommerce_app/services/product_details_Services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductSize? size;
  int quantity = 1;
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final productDetailsServices = ProductDetailsServicesImp();
  final favServces = FavoriteServicesImp();
  final authServices = AuthServicesImp();
  void getProductById(String id) async {
    try {
      emit(ProductDetailsLoading());
      ProductItemModel result = await productDetailsServices
          .fetchProductDetails(id);
      final favList = await favServces.fetchFavoritesProductList(
        authServices.currentUser()!.uid,
      );
      final isFav = favList.any((element) => element.productId == id);
      String? favId;
      if (isFav) {
         favId = favList
            .firstWhere((element) => element.productId == id)
            .id;
        result = result.copyWith(isFavorite: isFav);
      }
      emit(ProductDetailsLoaded(product: result,favId: favId));
    } catch (e) {
      emit(ProductDetailsLoadingError(message: e.toString()));
    }
  }

  void incerementCounter(String productId) {
    quantity++;
    emit(QuantityCounterChangedInProductDetailsPage(value: quantity));
  }

  void decerementCounter(String productId) {
    if (quantity > 1) {
      quantity--;
    }
    emit(QuantityCounterChangedInProductDetailsPage(value: quantity));
  }

  void productSizeSeleceted(ProductSize selectedSize) {
    size = selectedSize;
    emit(ProductSizeSelected(size: size));
  }

  Future<void> addToCart(String prodcutId) async {
    emit(ProductAddingToCart());
    try {
      final result = await productDetailsServices.fetchProductDetails(
        prodcutId,
      );

      final currentUser = authServices.currentUser();
      final cartItem = CartModel(
        id: DateTime.now().toIso8601String(),
        product: result,
        quantity: quantity,
        size: size!,
      );
      await productDetailsServices.addToCart(cartItem, currentUser!.uid);
      emit(ProductAddedToCart(productId: prodcutId));
    } catch (e) {
      emit(ProductAddingToCartError(message: e.toString()));
    }

    //emit(CartItemsLoaded(items: dummyCart, subtotal: 4));
  }
}
