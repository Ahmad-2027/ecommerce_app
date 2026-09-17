part of 'add_new_payment_card_cubit.dart';

sealed class AddNewPaymentCardState {}

final class AddNewPaymentCardInitial extends AddNewPaymentCardState {}

final class AddNewPaymentCardLoading extends AddNewPaymentCardState {}

final class AddNewPaymentCardLoaded extends AddNewPaymentCardState {

}

final class AddNewPaymentCardFailure extends AddNewPaymentCardState {
  final String message;
  AddNewPaymentCardFailure({required this.message});
}
