import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/add_new_payment_card_model.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final AddNewPaymentCardModel paymentMethod;
  const new({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

     //   showBottomSheet(context: context, builder: )
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
            leading: CachedNetworkImage(
              imageUrl: 'https://media.istockphoto.com/id/531236924/photo/group-of-credit-cards-on-computer-keyboard.jpg',
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Colors.red),
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
