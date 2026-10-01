import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());
  final paymentServices = CheckoutServicesImpl();
  final authService = AuthServicesImp();
  Future<void> addNewCardPayment({
    required String cardNumber,
    required String cvv,
    required String cardHolderName,
    required String expired,
  }) async {
    try {
      emit(AddNewPaymentCardLoading());
      final userId = authService.currentUser()!.uid;
      final result = await paymentServices.fetchPaymentMethods(userId);
      final bool isChossen = result.isEmpty;
      final card = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        expiredDate: expired,
        cvv: cvv,
        isChoosen: isChossen,
      );
      await paymentServices.addNewPaymentMethod(userId, card);
      emit(AddNewPaymentCardLoaded());
    } catch (e) {
      emit(AddNewPaymentCardFailure(message: e.toString()));
    }
  }

  Future<void> fetchPaymentMethods() async {
    try {
      emit(FetchingPaymentMethods());

      final result = await paymentServices.fetchPaymentMethods(
        authService.currentUser()!.uid,
      );
      if (result.isEmpty) {
        emit(FetchingPaymentMethodsFailure(message: "No payment methods"));
      } else {
        emit(FetchedPaymentMethods(paymentCards: result));
      }
    } catch (e) {
      emit(FetchingPaymentMethodsFailure(message: "No payment methods"));
    }
  }

  Future<void> confirmPaymentMethodChoosen(
    PaymentCardModel paymentSelected,
  ) async {
    try {
      emit(PaymentMethodChoosenLoading());
      final userId = authService.currentUser()!.uid;
      final result = await paymentServices.fetchPaymentMethods(userId);
      if (result.length == 1) {
        emit(PaymentMethodChoosen(false));
      } else {
        PaymentCardModel previousSelected = result.firstWhere(
          (element) => element.isChoosen == true,
        );
        if (previousSelected.id == paymentSelected.id) {
          emit(PaymentMethodChoosen(false));
        } else {
          previousSelected = previousSelected.copyWith(isChoosen: false);
          paymentSelected = paymentSelected.copyWith(isChoosen: true);
          await paymentServices.addNewPaymentMethod(userId, previousSelected);
          await paymentServices.addNewPaymentMethod(userId, paymentSelected);
          emit(PaymentMethodChoosen(true));
        }
      }
    } catch (e) {
      emit(PaymentMethodChoosingError(e.toString()));
    }
  }

  void selectPaymentMethodTemporary() {
    emit(PaymentMethodChoosenTemporory());
  }
}
