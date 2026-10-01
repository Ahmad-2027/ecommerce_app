import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/payment_card_model.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/view_models/payment_methods_cubit/payment_methods_cubit.dart';
import 'package:ecommerce_app/views/pages/widgets/payment_method_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCardModel paymentMethod;
  const new({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.grey.shade100,
          useRootNavigator: true,
          builder: (context) => BlocProvider(
            create: (context) {
              final cubit = PaymentMethodsCubit();
              cubit.fetchPaymentMethods();
              return cubit;
            },
            child: PaymentMethodBottomSheet(),
          ),
        ).then((value) {
          if (value == true) {
            cubit.getCartItemscheckoutPage();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListTile(
            leading: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade100,
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/128/14035/14035060.png',
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.red),
              ),
            ),
            title: Text(paymentMethod.cardNumber),
            subtitle: Text("Master Card"),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
