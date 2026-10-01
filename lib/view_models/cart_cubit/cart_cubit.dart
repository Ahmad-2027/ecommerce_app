
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  int quantity = 1;
  String? selectedcartItemId;
  CartCubit() : super(CartInitial());
  final authServices = AuthServicesImp();
  final cartServices = CartServicesImpl();
  Future<void> getCartItems() async {
    try {
      emit(CartItemsLoading());

      final cartItems = await cartServices.fetchCartItems(
        authServices.currentUser()!.uid,
      );
      final subTotal = _getSubTotale(cartItems);
      emit(CartItemsLoaded(items: cartItems, subtotal: subTotal));
    } catch (e) {
      emit(CartItemsLoadingError(message: e.toString()));
    }
  }

/*   Future<bool> hasInternet() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.contains(ConnectivityResult.wifi) ||
        connectivity.contains(ConnectivityResult.mobile) ||
        connectivity.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  } */

  Future<void> removeCartItem(String cartItemId) async {
    try {
      emit(CartItemRemoving());
      await cartServices.deleteCartItem(
        authServices.currentUser()!.uid,
        cartItemId,
      );
      emit(CartItemRemoved());
    } catch (e) {
      emit(CartItemRemovingError(message: e.toString()));
    }
  }

  Future<void> incerementCounter(CartModel cartItem) async {
    final int oldValue = cartItem.quantity;
    try {
    /*   if (!await hasInternet()) {
        throw Exception("No internet connection");
      } */
      emit(QuantityCounterChangingInCartPage(expectedValue:  oldValue + 1,cartItemId: cartItem.id));

      cartItem = cartItem.copyWith(quantity: oldValue + 1);
      await cartServices.updateCartItemQuantity(
        authServices.currentUser()!.uid,
        cartItem,
      );
      final cartItems = await cartServices.fetchCartItems(
        authServices.currentUser()!.uid,
      );
      final subTotal = _getSubTotale(cartItems);
      emit(
        QuantityCounterChangedInCartPage(
          cartModel: cartItem,
          newSubTotal: subTotal,
          cartItemId: cartItem.id
        ),
      );
    } catch (e) {
      emit(
        QuantityCounterChangingInCartPageError(
          message: e.toString(),
          oldValue: oldValue,
          cartItemId: cartItem.id
        ),
      );
    }
  }

  Future<void> decerementCounter(CartModel cartItem) async {
    final int oldValue = cartItem.quantity;
    try {
   /*    if (!await hasInternet()) {
        throw Exception("No internet connection");
      } */
      if (cartItem.quantity > 1) {
        emit(QuantityCounterChangingInCartPage(expectedValue:  oldValue - 1,cartItemId: cartItem.id));
        cartItem = cartItem.copyWith(quantity: oldValue - 1);
        await cartServices.updateCartItemQuantity(
          authServices.currentUser()!.uid,
          cartItem,
        );
      }
      final cartItems = await cartServices.fetchCartItems(
        authServices.currentUser()!.uid,
      );
      final subTotal = _getSubTotale(cartItems);

      emit(
        QuantityCounterChangedInCartPage(
          cartModel: cartItem,
          newSubTotal: subTotal,
          cartItemId: cartItem.id
        ),
      );
    } catch (e) {
      emit(
        QuantityCounterChangingInCartPageError(
          message: e.toString(),
          oldValue: oldValue,
          cartItemId: cartItem.id
        ),
      );
    }
  }

  double _getSubTotale(List<CartModel> cartItems) {
    if (cartItems.isEmpty) {
      return 0;
    }
    return cartItems.fold<double>(
      0,
      ((previousValue, element) =>
          previousValue + (element.product.price * element.quantity)),
    );
  }
}
