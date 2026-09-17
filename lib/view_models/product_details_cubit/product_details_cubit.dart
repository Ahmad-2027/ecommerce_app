import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductSize? size;
  int quantity = 1;
  ProductDetailsCubit() : super(ProductDetailsInitial());
  void getProductById(String id) async {
    emit(ProductDetailsLoading());
    
    final product = dummyProducts.firstWhere((item) => item.id == id);
    await Future.delayed(Duration(seconds: 1),(){
      
    emit(ProductDetailsLoaded(product: product));

    });
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

  void addToCart(String prodcutId) async {
    emit(ProductAddingToCart());
    final cartItem = AddToCartModel(
      id: DateTime.now().toIso8601String(),
      product: dummyProducts.firstWhere((item) => item.id == prodcutId),
      quantity: quantity,
      size: size!,
    );
    dummyCart.add(cartItem);
    await Future.delayed(Duration(seconds: 1),(){
    emit(ProductAddedToCart(productId: prodcutId));});
    //emit(CartItemsLoaded(items: dummyCart, subtotal: 4));
  }
}
