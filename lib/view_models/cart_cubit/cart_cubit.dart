import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  int quantity = 1;
  CartCubit() : super(CartInitial());

  void getCartItems() {
    emit(CartItemsLoading());
    Future.delayed(Duration(seconds: 1),(){

    emit(CartItemsLoaded(items: dummyCart, subtotal: _getSubTotale()));
    });
  }

  void incerementCounter(String id, [int? initialvalue]) {
    if (initialvalue != null) {
      quantity = initialvalue;
    }
    quantity++;
    int selectedIndex = dummyCart.indexWhere((element) => element.id == id);
    dummyCart[selectedIndex] = dummyCart[selectedIndex].copyWith(
      quantity: quantity,
    );

    emit(
      QuantityCounterChangedInCartPage(
        value: quantity,
        productId: id,
        newSubTotal: _getSubTotale(),
      ),
    );
  }

  void decerementCounter(String id, [int? initialvalue]) {
    if (quantity > 1) {
      if (initialvalue != null) {
        quantity = initialvalue;
      }
      quantity--;
      int selectedIndex = dummyCart.indexWhere((element) => element.id == id);
      dummyCart[selectedIndex] = dummyCart[selectedIndex].copyWith(
        quantity: quantity,
      );
    }

    emit(
      QuantityCounterChangedInCartPage(
        value: quantity,
        productId: id,
        newSubTotal: _getSubTotale(),
      ),
    );
  }

  double _getSubTotale() => dummyCart.fold<double>(
    0,
    ((previousValue, element) =>
        previousValue + (element.product.price * element.quantity)),
  );
}
