import 'package:ecommerce_app/models/add_new_payment_card_model.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  void getCartItems() {
    emit(CheckoutItemsLoading());
    final cartItems = dummyCart;
    final totalAmount = cartItems.fold<double>(
      0,
      ((previousValue, element) =>
          previousValue + (element.product.price * element.quantity)),
    );
    final numOfProducts = dummyCart.fold<int>(
      0,
      ((previousValue, element) => previousValue + element.quantity),
    );
    Future.delayed(Duration(seconds: 3));
    emit(
      CheckoutItemsLoaded(
        cartItems: cartItems,
        numOfProducts: numOfProducts,
        totalAmount: totalAmount + 10,
        paymentMethods: dumyPaymentCards
      ),
    );
  }
}
