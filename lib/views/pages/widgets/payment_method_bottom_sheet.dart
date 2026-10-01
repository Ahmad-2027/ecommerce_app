import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/utitlities/app_routes.dart';
import 'package:ecommerce_app/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  const new({super.key});

  @override
  State<PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  PaymentCardModel? _paymentMethodSelected;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is PaymentMethodChoosen) {
            Navigator.of(context).pop(state.isChanged);
          }
        },
        listenWhen: (previous, current) => current is PaymentMethodChoosen,
        buildWhen: (previous, current) =>
            current is FetchedPaymentMethods ||
            current is FetchingPaymentMethods ||
            current is FetchingPaymentMethodsFailure,
        builder: (context, state) {
          if (state is FetchingPaymentMethods) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FetchedPaymentMethods) {
            final paymentCards = state.paymentCards;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 36,
                    right: 16.0,
                    left: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment methods",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: paymentCards.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _paymentMethodSelected = paymentCards[index];
                              cubit.selectPaymentMethodTemporary();
                            },
                            child:
                                BlocBuilder<
                                  PaymentMethodsCubit,
                                  PaymentMethodsState
                                >(
                                  buildWhen: (previous, current) =>
                                      current
                                          is PaymentMethodChoosenTemporory ||
                                      current is FetchedPaymentMethods,
                                  builder: (context, state) {
                                    if (state is FetchedPaymentMethods) {
                                      _paymentMethodSelected = state
                                          .paymentCards
                                          .firstWhere(
                                            (element) =>
                                                element.isChoosen == true,
                                          );
                                    }
                                    return RadioGroup(
                                      onChanged: (value) {},
                                      groupValue: _paymentMethodSelected!.id,
                                      child: InkWell(
                                        child: Card(
                                          elevation: 3,
                                          color: Colors.white,
                                          child: ListTile(
                                            leading: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: Colors.grey.shade100,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: 'https://cdn-icons-png.flaticon.com/128/14035/14035060.png',
                                                fit: BoxFit.contain,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator.adaptive(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                              ),
                                            ),
                                            title: Text(
                                              paymentCards[index].cardNumber,
                                            ),
                                            subtitle: Text(
                                              paymentCards[index]
                                                  .cardHolderName,
                                            ),
                                            trailing: Radio(
                                              value: paymentCards[index].id,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          );
                        },
                      ),

                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.addNewCardMethod)
                              .then((value) {
                                if (value != null) {
                                  cubit.fetchPaymentMethods();
                                }
                              });
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 3,
                          child: ListTile(
                            leading: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                              ),
                              child: Icon(Icons.add),
                            ),
                            title: Text("Add new payment method"),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child:
                            BlocBuilder<
                              PaymentMethodsCubit,
                              PaymentMethodsState
                            >(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is PaymentMethodChoosenLoading,
                              builder: (context, state) {
                                if (state is PaymentMethodChoosenLoading) {
                                  return ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .primaryColor,
                                      foregroundColor: Colors.white,
                                    ),
                                    child:
                                        const CircularProgressIndicator.adaptive(
                                          backgroundColor: Colors.white,
                                        ),
                                  );
                                }
                                return ElevatedButton(
                                  onPressed: () async {
                                    await cubit.confirmPaymentMethodChoosen(
                                      _paymentMethodSelected!,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    "Confirm Payment",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
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
            );
          } else if (state is FetchingPaymentMethodsFailure) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
