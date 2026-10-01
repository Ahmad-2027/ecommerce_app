part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}

final class AddNewPaymentCardLoading extends PaymentMethodsState {}

final class AddNewPaymentCardLoaded extends PaymentMethodsState {}

final class AddNewPaymentCardFailure extends PaymentMethodsState {
  final String message;
  AddNewPaymentCardFailure({required this.message});
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCardModel> paymentCards;
  FetchedPaymentMethods({required this.paymentCards});
}

final class FetchingPaymentMethodsFailure extends PaymentMethodsState {
  final String message;
  FetchingPaymentMethodsFailure({required this.message});
}

final class PaymentMethodChoosen extends PaymentMethodsState {
  final bool isChanged;
  PaymentMethodChoosen(this.isChanged);
}
final class PaymentMethodChoosenLoading extends PaymentMethodsState {
}

final class PaymentMethodChoosingError extends PaymentMethodsState {
  final String message;
  PaymentMethodChoosingError(this.message);
}

final class PaymentMethodChoosenTemporory extends PaymentMethodsState {}
