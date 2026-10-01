import 'package:ecommerce_app/models/location_model.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/models/add_to_cart_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  final cartServices = CartServicesImpl();
  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImp();

  Future<void> getCartItemscheckoutPage() async {
    try {
      emit(CheckoutItemsLoading());

      final userId = authServices.currentUser()!.uid;
      final cartItems = await cartServices.fetchCartItems(userId);
          if (isClosed) return;

      final totalAmount = cartItems.fold<double>(
        0,
        ((previousValue, element) =>
            previousValue + (element.product.price * element.quantity)),
      );
      final numOfProducts = cartItems.fold<int>(
        0,
        ((previousValue, element) => previousValue + element.quantity),
      );
      final paymentMethods = await checkoutServices.fetchPaymentMethods(userId);
          if (isClosed) return;

      final paymentMethod = paymentMethods.isEmpty
          ? null
          : paymentMethods.firstWhere((element) => element.isChoosen == true);
      final locations = await checkoutServices.fetchLocations(userId);
          if (isClosed) return;

   
      final LocationModel? locationSelected = locations.isEmpty
          ? null
          : locations.firstWhere((element) => element.isSelected==true);

      emit(
        CheckoutItemsLoaded(
          cartItems: cartItems,
          numOfProducts: numOfProducts,
          totalAmount: totalAmount + 10,
          paymentMethod: paymentMethod,
          shippingLocation: locationSelected,
        ),
      );
    } catch (e) {
      emit(CheckoutItemsLoadingError(message: e.toString()));
    }
  }
}
