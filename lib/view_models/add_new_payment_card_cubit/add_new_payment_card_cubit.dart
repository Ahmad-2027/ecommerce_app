import 'package:ecommerce_app/models/add_new_payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_payment_card_state.dart';

class AddNewPaymentCardCubit extends Cubit<AddNewPaymentCardState> {
  AddNewPaymentCardCubit() : super(AddNewPaymentCardInitial());
  void addNewCardPayment({
   required String cardNumber,
   required String cvv,
  required  String cardHolderName,
   required String expired,
  }) {
    emit(AddNewPaymentCardLoading());
    final card = AddNewPaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiredDate: expired,
      cvv: cvv,
    );
    dumyPaymentCards.add(card);
    Future.delayed(Duration(seconds: 1), () {
      emit(AddNewPaymentCardLoaded());
    });
  }
}
