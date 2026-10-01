import 'package:ecommerce_app/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/label_with_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewPaymentCardPage extends StatefulWidget {
  const new({super.key});

  @override
  State<AddNewPaymentCardPage> createState() => _AddNewPaymentCardPageState();
}

class _AddNewPaymentCardPageState extends State<AddNewPaymentCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add new card"), centerTitle: true),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWithTextField(
                  label: 'Card Number',
                  controller: _cardNumberController,
                  prefixIcon: Icons.credit_card,
                  hintText: 'Enter card number',
                ),
                const SizedBox(height: 20),
                LabelWithTextField(
                  label: 'Card Holder Name',
                  controller: _cardHolderNameController,
                  prefixIcon: Icons.person,
                  hintText: 'Enter card holder name',
                ),
                const SizedBox(height: 20),
                LabelWithTextField(
                  label: 'Expiry Date',
                  controller: _expiryDateController,
                  prefixIcon: Icons.date_range,
                  hintText: 'Enter expiry date',
                ),
                const SizedBox(height: 20),
                LabelWithTextField(
                  label: 'CVV',
                  controller: _cvvController,
                  prefixIcon: Icons.password,
                  hintText: 'Enter cvv',
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                    bloc: cubit,
                    listenWhen: (previous, current) =>
                        current is AddNewPaymentCardFailure ||
                        current is AddNewPaymentCardLoaded,
                    listener: (context, state) {
                      if (state is AddNewPaymentCardLoaded) {
                        Navigator.pop(context,true);
                      } else if (state is AddNewPaymentCardFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AddNewPaymentCardFailure ||
                        current is AddNewPaymentCardLoaded ||
                        current is AddNewPaymentCardLoading,

                    builder: (context, state) {
                      if (state is AddNewPaymentCardLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.addNewCardPayment(
                              cardNumber: _cardNumberController.text,
                              expired: _expiryDateController.text,
                              cvv: _cvvController.text,
                              cardHolderName: _cardHolderNameController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Add card",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight(600),
                                color: Colors.white,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
